module PhantomjsHelper

  # requires casperjs (installed by `npm install -g casperjs`)
  def casper_run(file, *args)
    `/usr/bin/casperjs #{Rails.root}/lib/phantomjs/#{file}.js #{args.join ' '}`
  end
end
