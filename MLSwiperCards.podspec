Pod::Spec.new do |s|
 s.name = 'MLSwiperCards'
 s.version = '0.0.1'
 s.license = { :type => "MIT", :file => "LICENSE" }
 s.summary = 'A simple and elegant Swiper Cards with Swift'
 s.homepage = 'http://micheltlutz.me'
 s.social_media_url = 'https://twitter.com/michel_lutz'
 s.authors = { "Michel Lutz & Marcos Lacerda" => "michel_lutz@icloud.com" }
 s.source = { :git => "https://github.com/micheltlutz/MLSwiperCards.git", :tag => "v"+s.version.to_s }
 s.platforms = { :ios => "10.0", :osx => "10.10", :tvos => "9.0", :watchos => "2.0" }
 s.requires_arc = true

 s.default_subspec = "Core"
 s.subspec "Core" do |ss|
     ss.source_files  = "Sources/**/*.swift"
     ss.framework  = "Foundation"
 end
end
