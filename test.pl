# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

use Tk::Enscript;

print "1..50\n";

print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

use FindBin;
use Tk;
my $top = new MainWindow;

$tmpdir = "$FindBin::RealBin/tmp";

$ok = 2;

enscript($top,
	 -font => "Courier7",
	 -media => 'A5',
	 -file => "Enscript.pm",
	 -output => "$tmpdir/test-%02d.ps",
	);
print "not " if !-f "$tmpdir/test-00.ps";
print "ok " . $ok++ . "\n";

foreach my $external ('', 'enscript', 'a2ps') {
    for my $psname (keys %Tk::Enscript::postscript_to_x11_font) {
	next if !defined $Tk::Enscript::postscript_to_x11_font{$psname};
	my $psname1 = ucfirst($psname);
	$psname1 =~ s/-([a-z])/-\U$1/g;
	my $filebase = "$tmpdir/test-$psname-$external";
	my $out = ($external eq '' ? "${filebase}-%02d.ps" : $filebase.".ps");
	enscript($top,
		 ($external ne '' ? (-external => $external) : ()),
		 -font => $psname1 . "10",
		 -media => 'A4',
		 -file => "MANIFEST",
		 -output => $out,
		);
	print "not " if (($external eq '' && !-f "${filebase}-00.ps") ||
			 ($external ne '' && !-f "${filebase}.ps"));
	print "ok " . $ok++ . "\n";
    }
}
    
#MainLoop;

