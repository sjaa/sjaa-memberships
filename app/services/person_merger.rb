# Service class for merging two Person records
# This class provides a reusable kernel for merging duplicate people in the database
class PersonMerger
  attr_reader :keeper, :duplicate, :commit

  def initialize(keeper:, duplicate:, commit: false)
    @keeper = keeper
    @duplicate = duplicate
    @commit = commit
  end

  # Main entry point - performs the merge operation
  def merge!
    validate_inputs!

    if commit
      perform_merge
    else
      preview_merge
    end
  end

  # Class method for easy one-line merging
  def self.merge!(keeper:, duplicate:, commit: false)
    new(keeper: keeper, duplicate: duplicate, commit: commit).merge!
  end

  # Preview what would be merged without committing
  def preview_merge
    puts "\n  " + "=" * 76
    puts "  PREVIEW OF MERGED RECORD - Person ##{keeper.id}"
    puts "  " + "=" * 76
    display_merge_preview
    puts "  " + "=" * 76
    puts "\n  → Would merge Person ##{duplicate.id} into Person ##{keeper.id} (dry-run)"
  end

  # Perform the actual merge in a transaction
  def perform_merge
    puts "\n  " + "=" * 76
    puts "  MERGED RECORD - Person ##{keeper.id}"
    puts "  " + "=" * 76
    display_merge_preview
    puts "  " + "=" * 76

    ActiveRecord::Base.transaction do
      puts "\n  Merging Person ##{duplicate.id} into Person ##{keeper.id}..."

      merge_memberships
      merge_donations
      merge_equipment
      merge_contacts
      merge_interests
      merge_groups
      merge_permissions
      merge_skills
      merge_notes
      merge_fields
      merge_profile_picture

      # Delete the duplicate person
      duplicate.reload.destroy!
      puts "    ✓ Deleted Person ##{duplicate.id}"
    end

    puts "\n  ✓ Successfully merged Person ##{duplicate.id} into Person ##{keeper.id}"
  end

  private

  def validate_inputs!
    raise ArgumentError, "Keeper must be a Person" unless keeper.is_a?(Person)
    raise ArgumentError, "Duplicate must be a Person" unless duplicate.is_a?(Person)
    raise ArgumentError, "Cannot merge a person into itself" if keeper.id == duplicate.id
  end

  def display_merge_preview
    puts "  Name: #{keeper.name}"
    puts "  Created: #{keeper.created_at}"
    puts "  Updated: #{keeper.updated_at}"

    display_merged_fields
    display_profile_picture
    display_contacts_preview
    display_memberships_preview
    display_donations_preview
    display_equipment_preview
    display_interests_preview
    display_groups_preview
    display_permissions_preview
    display_skills_preview
    display_notes_preview
  end

  def display_merged_fields
    merged_discord = duplicate.discord_id.present? ? duplicate.discord_id : keeper.discord_id
    merged_astrobin = duplicate.astrobin_id.present? ? duplicate.astrobin_id : keeper.astrobin_id
    merged_telescopius = duplicate.telescopius_id.present? ? duplicate.telescopius_id : keeper.telescopius_id
    merged_referral = duplicate.referral_id.present? ? duplicate.referral : keeper.referral
    merged_volunteer = keeper.volunteer || duplicate.volunteer
    merged_mentor = keeper.mentor || duplicate.mentor

    puts "  Discord: #{merged_discord}" if merged_discord.present?
    puts "  AstroBin: #{merged_astrobin}" if merged_astrobin.present?
    puts "  Telescopius: #{merged_telescopius}" if merged_telescopius.present?
    puts "  Referral: #{merged_referral&.name}" if merged_referral.present?
    puts "  Volunteer: #{merged_volunteer ? 'Yes' : 'No'}"
    puts "  Mentor: #{merged_mentor ? 'Yes' : 'No'}"
  end

  def display_profile_picture
    has_profile_pic = keeper.profile_picture.attached? || duplicate.profile_picture.attached?
    if has_profile_pic
      pic_source = if keeper.profile_picture.attached?
        "from keeper"
      else
        "from Person ##{duplicate.id}"
      end
      puts "  Profile Picture: Yes (#{pic_source})"
    end
  end

  def display_contacts_preview
    all_contacts = [keeper, duplicate].flat_map(&:contacts).uniq
    puts "\n  Contacts (#{all_contacts.size}):"

    contacts_by_email = all_contacts.group_by { |c| c.email&.downcase }
    contacts_by_email.each_with_index do |(email_key, contact_group), cidx|
      main_contact = contact_group.find { |c| c.person_id == keeper.id } || contact_group.first
      other_contacts = contact_group - [main_contact]

      primary_flag = main_contact.primary || (main_contact.person_id == keeper.id && keeper.primary_contact&.email&.downcase == email_key)
      puts "    #{cidx + 1}. #{main_contact.email}#{primary_flag ? ' (PRIMARY)' : ''}"

      address = other_contacts.find { |c| c.address.present? }&.address || main_contact.address
      city = other_contacts.find { |c| c.city_id.present? }&.city || main_contact.city
      state = other_contacts.find { |c| c.state_id.present? }&.state || main_contact.state
      zipcode = other_contacts.find { |c| c.zipcode.present? }&.zipcode || main_contact.zipcode
      phone = other_contacts.find { |c| c.phone.present? }&.phone || main_contact.phone

      puts "       Address: #{address}" if address.present?
      puts "       City: #{city&.name}" if city.present?
      puts "       State: #{state&.name}" if state.present?
      puts "       Zipcode: #{zipcode}" if zipcode.present?
      puts "       Phone: #{phone}" if phone.present?

      if other_contacts.any? && !commit
        puts "       (Will merge data from #{other_contacts.size} duplicate contact(s))"
      end
    end
  end

  def display_memberships_preview
    all_memberships = [keeper, duplicate].flat_map(&:memberships).uniq
    puts "\n  Memberships (#{all_memberships.size}):"

    all_memberships.sort_by { |m| m.start || DateTime.now }.reverse.each_with_index do |membership, midx|
      end_date = membership.end ? membership.end.strftime('%Y-%m-%d') : 'LIFETIME'
      status = membership.is_active? ? '✓ ACTIVE' : '✗ EXPIRED'
      source = membership.person_id == keeper.id ? '' : " (from Person ##{membership.person_id})"
      puts "    #{midx + 1}. #{membership.kind&.name}: #{membership.start&.strftime('%Y-%m-%d')} → #{end_date} (#{membership.term_months || 'N/A'} months) [#{status}]#{source}"
      puts "       Ephemeris: #{membership.ephemeris ? 'Yes' : 'No'}" if membership.respond_to?(:ephemeris)
    end
  end

  def display_donations_preview
    all_donations = [keeper, duplicate].flat_map(&:donations).uniq
    if all_donations.any?
      total_donations = all_donations.sum(&:amount)
      puts "\n  Donations (#{all_donations.count}): Total $#{total_donations}"
      all_donations.sort_by(&:created_at).reverse.first(5).each_with_index do |donation, didx|
        source = donation.person_id == keeper.id ? '' : " (from Person ##{donation.person_id})"
        if donation.notes.present?
          puts "    #{didx + 1}. $#{donation.amount} - #{donation.notes}#{source}"
        else
          puts "    #{didx + 1}. $#{donation.amount}#{source}"
        end
      end
      puts "    ... and #{all_donations.count - 5} more" if all_donations.count > 5
    end
  end

  def display_equipment_preview
    all_equipment = [keeper, duplicate].flat_map(&:equipment).uniq
    if all_equipment.any?
      puts "\n  Equipment (#{all_equipment.size}):"
      all_equipment.each_with_index do |equip, eidx|
        source = equip.person_id == keeper.id ? '' : " (from Person ##{equip.person_id})"
        instrument_display = equip.instrument ? "#{equip.instrument.kind}#{equip.instrument.model.present? ? " #{equip.instrument.model}" : ''}" : "Unknown"
        note_display = equip.note.present? ? " - #{equip.note}" : ''
        puts "    #{eidx + 1}. #{instrument_display}#{note_display}#{source}"
      end
    end
  end

  def display_interests_preview
    all_interests = [keeper, duplicate].flat_map(&:interests).uniq
    if all_interests.any?
      puts "\n  Interests (#{all_interests.count}): #{all_interests.map(&:name).join(', ')}"
    end
  end

  def display_groups_preview
    all_groups = [keeper, duplicate].flat_map(&:groups).uniq
    if all_groups.any?
      puts "\n  Groups (#{all_groups.count}): #{all_groups.map(&:name).join(', ')}"
    end
  end

  def display_permissions_preview
    all_permissions = [keeper, duplicate].flat_map(&:permissions).uniq
    if all_permissions.any?
      puts "\n  Permissions (#{all_permissions.count}): #{all_permissions.map(&:name).join(', ')}"
    end
  end

  def display_skills_preview
    all_skills_hash = {}
    [keeper, duplicate].each do |person|
      person.people_skills.each do |ps|
        if !all_skills_hash[ps.skill_id] || ps.skill_level > all_skills_hash[ps.skill_id][:level]
          all_skills_hash[ps.skill_id] = { skill: ps.skill, level: ps.skill_level }
        end
      end
    end

    if all_skills_hash.any?
      puts "\n  Skills (#{all_skills_hash.count}):"
      all_skills_hash.each_with_index do |(skill_id, skill_data), sidx|
        puts "    #{sidx + 1}. #{skill_data[:skill].name}: Level #{skill_data[:level]}"
      end
    end
  end

  def display_notes_preview
    all_notes = [keeper, duplicate].map(&:notes).compact.reject(&:blank?).uniq
    if all_notes.any?
      merged_notes = all_notes.join("\n---\n")
      notes_preview = merged_notes.length > 200 ? "#{merged_notes[0..200]}..." : merged_notes
      puts "\n  Notes: #{notes_preview}"
    end
  end

  def merge_memberships
    duplicate.memberships.each do |membership|
      # Check if keeper already has a membership with same start date and kind
      existing = keeper.memberships.find { |m| m.start == membership.start && m.kind_id == membership.kind_id }
      unless existing
        membership.update!(person_id: keeper.id)
        puts "    → Moved membership: #{membership.start} (#{membership.term_months} months)"
      else
        puts "    → Skipped duplicate membership: #{membership.start}"
      end
    end
  end

  def merge_donations
    duplicate.donations.each do |donation|
      donation.update!(person_id: keeper.id)
      puts "    → Moved donation: $#{donation.amount}"
    end
  end

  def merge_equipment
    duplicate.equipment.each do |equip|
      # Check if keeper already has equipment with same instrument and note
      existing = keeper.equipment.find { |e| e.instrument_id == equip.instrument_id && e.note == equip.note }
      unless existing
        equip.update!(person_id: keeper.id)
        instrument_display = equip.instrument ? "#{equip.instrument.kind}#{equip.instrument.model.present? ? " #{equip.instrument.model}" : ''}" : "Unknown"
        puts "    → Moved equipment: #{instrument_display}"
      else
        instrument_display = equip.instrument ? "#{equip.instrument.kind}#{equip.instrument.model.present? ? " #{equip.instrument.model}" : ''}" : "Unknown"
        puts "    → Skipped duplicate equipment: #{instrument_display}"
      end
    end
  end

  def merge_contacts
    duplicate.contacts.each do |contact|
      # Check if this exact email already exists for keeper
      existing = keeper.contacts.find { |c| c.email&.downcase == contact.email&.downcase }
      if existing
        # If the duplicate's contact has more complete info, update the keeper's contact
        updates = {}
        if contact.address.present? && existing.address.blank?
          updates[:address] = contact.address
          puts "    → Updated keeper's contact address"
        end
        if contact.phone.present? && existing.phone.blank?
          updates[:phone] = contact.phone
          puts "    → Updated keeper's contact phone"
        end
        if contact.city_id.present? && existing.city_id.blank?
          updates[:city_id] = contact.city_id
          puts "    → Updated keeper's contact city"
        end
        if contact.state_id.present? && existing.state_id.blank?
          updates[:state_id] = contact.state_id
          puts "    → Updated keeper's contact state"
        end
        if contact.zipcode.present? && existing.zipcode.blank?
          updates[:zipcode] = contact.zipcode
          puts "    → Updated keeper's contact zipcode"
        end
        existing.update_columns(updates) if updates.any?

        # Delete the duplicate contact
        contact.destroy!
        puts "    → Deleted duplicate contact: #{contact.email}"
      else
        # Move contact to keeper, but ensure only one primary
        contact.update!(person_id: keeper.id, primary: false)
        puts "    → Moved contact: #{contact.email}"
      end
    end
  end

  def merge_interests
    new_interests = duplicate.interests - keeper.interests
    keeper.interests << new_interests
    puts "    → Added #{new_interests.size} interests" if new_interests.any?
  end

  def merge_groups
    new_groups = duplicate.groups - keeper.groups
    keeper.groups << new_groups
    puts "    → Added #{new_groups.size} groups" if new_groups.any?
  end

  def merge_permissions
    new_permissions = duplicate.permissions - keeper.permissions
    keeper.permissions << new_permissions
    puts "    → Added #{new_permissions.size} permissions" if new_permissions.any?
  end

  def merge_skills
    duplicate.people_skills.each do |dup_skill|
      keeper_skill = keeper.people_skills.find { |ks| ks.skill_id == dup_skill.skill_id }
      if keeper_skill
        if dup_skill.skill_level > keeper_skill.skill_level
          keeper_skill.update!(skill_level: dup_skill.skill_level)
          puts "    → Updated skill level: #{dup_skill.skill.name} to #{dup_skill.skill_level}"
        end
      else
        dup_skill.update!(person_id: keeper.id)
        puts "    → Moved skill: #{dup_skill.skill.name} (level #{dup_skill.skill_level})"
      end
    end
  end

  def merge_notes
    if duplicate.notes.present? && duplicate.notes != keeper.notes
      keeper.notes = [keeper.notes, duplicate.notes].compact.join("\n---\n")
      keeper.save!
      puts "    → Appended notes"
    end
  end

  def merge_fields
    if duplicate.discord_id.present? && keeper.discord_id.blank?
      keeper.update!(discord_id: duplicate.discord_id)
      puts "    → Updated discord_id"
    end
    if duplicate.astrobin_id.present? && keeper.astrobin_id.blank?
      keeper.update!(astrobin_id: duplicate.astrobin_id)
      puts "    → Updated astrobin_id"
    end
    if duplicate.telescopius_id.present? && keeper.telescopius_id.blank?
      keeper.update!(telescopius_id: duplicate.telescopius_id)
      puts "    → Updated telescopius_id"
    end
    if duplicate.referral_id.present? && keeper.referral_id.blank?
      keeper.update!(referral_id: duplicate.referral_id)
      puts "    → Updated referral_id"
    end
    keeper.update!(volunteer: true) if duplicate.volunteer && !keeper.volunteer
    keeper.update!(mentor: true) if duplicate.mentor && !keeper.mentor
  end

  def merge_profile_picture
    if duplicate.profile_picture.attached? && !keeper.profile_picture.attached?
      # Copy the blob from duplicate to keeper
      keeper.profile_picture.attach(duplicate.profile_picture.blob)
      puts "    → Attached profile picture from duplicate"
    end
  end
end
