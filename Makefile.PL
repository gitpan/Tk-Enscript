use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile
  (
   'NAME'	  => 'Tk::Enscript',
   'VERSION_FROM' => 'Enscript.pm', # finds $VERSION
   'PM'           => {'Enscript.pm'  => '$(INST_LIBDIR)/Enscript.pm',
		      'enscript.cfg' => '$(INST_LIBDIR)/enscript.cfg',
		      ,
		     }
);
