Pod::Spec.new do |s|
  s.name                 = 'TickleLocalization'
  s.version              = '0.0.1'
  s.summary              = 'Localized strings of Tickle'
  s.license              = 'Apache License 2.0'
  s.author               = { 'sodas tsai' => 'sodas@tickleapp.com' }

  s.platform             = :ios, '8.0'
  s.requires_arc         = true

  s.source = {
    :git => 'https://github.com/tickleapp/localization.git',
    :branch => 'master',
  }

  # Iterate components
  s_default_subspecs = []
  ['Arctic', 'Core', 'Devices', 'Main', 'Tracker'].each do |component|
    # Create a subspec for this component
    s_default_subspecs.append(component)
    s.subspec component do |ss|
      # Iterate locales
      ss_default_subspecs = []
      Dir["#{component}/*.lproj"].each do |locale_path|
        locale = locale_path.split(File::SEPARATOR)[-1].split('.')[0]
        # Create a subspec for this locale
        ss_default_subspecs.append(locale)
        ss.subspec locale do |sss|
          # The content of this subspec is the whole locale content
          sss.resources = locale_path
        end
      end
    end
  end

  s.default_subspecs = s_default_subspecs
end
