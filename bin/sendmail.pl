#!/usr/bin/perl -w

use strict;
use warnings;



################################### ~~~~~~ VARIABLES ~~~~~~~~ ###########################

my $TOEMAILS = 'recipents@mailinator.com';
my $FROM = 'recipents@mailinator.com';
use lib qw(/ots/clone_patch/AUTO_TEST/validation/bin/libs);
my $STMPPATH=$ARGV[3];

#########################################################################################
use MIME::Lite;


my $subject = "$ARGV[0] $ARGV[1]-Clone Report";
my $html_data = `cat $ARGV[2]`;

my $msg = MIME::Lite->new(
                 From     => $FROM,
                 To       => $TOEMAILS,
                # Cc       => $CCEMAILS,
                 Subject  => $subject,
                 Disposition  => 'inline',
                 Type     => 'multipart/mixed'
                 ) or die "Error creating multipart container: $!\n";

$msg->attach(Type         => 'text/html',
             Data         => $html_data
             );

my @files = ('fnd_concurrent_queues.out','fnd_profile_option_values.out','utl_file_dir.out','dba_directories.out','conc_manager_processes.out','conc_mngr_PSnodes.out');

foreach ( @files ) {

$msg->attach(Type         => 'TEXT',
                         Path => "$STMPPATH${_}",
                         Filename => "$_",
                         Disposition => 'attachment'
             );


}

$msg->send;
