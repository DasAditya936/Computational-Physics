#!/usr/bin/perl
use strict;
use warnings;

# Slurp mode: read the entire file into $content
undef $/;
my $content = <>;
if (!defined $content) { exit; }

# We will build the new content in $output
my $output = "";
my $last_pos = 0;

# Regex to find math containers: $...$ or $$...$$
# Uses (?<!\\) to avoid escaped \$
# g: global, s: dot matches newline
while ($content =~ /(?<!\\)(\${1,2})(.+?)(?<!\\)\1/gs) {
    # Capture the positions before we do anything else
    # @- and @+ are special arrays containing match offsets
    my $start_pos = $-[0];
    my $end_pos   = $+[0];
    my $delim     = $1;
    my $math      = $2;

    # Append text before the match
    $output .= substr($content, $last_pos, $start_pos - $last_pos);

    # Phase 1: Normalization (Trim internal whitespace)
    $math =~ s/^\s+|\s+$//g;

    # Phase 2: The Contact Test
    # Get the text before and after on the same lines
    my $pre_text = substr($content, 0, $start_pos);
    my $post_text = substr($content, $end_pos);
    
    my $line_before = ($pre_text =~ m/([^\n]*)$/) ? $1 : "";
    my $line_after = ($post_text =~ m/^([^\n]*)/) ? $1 : "";

    if ($line_before =~ m/\S/ || $line_after =~ m/\S/) {
        # CASE A: INLINE (Touching text)
        $math =~ s/\n/ /g; # Flatten
        $output .= "\$$math\$";
    } else {
        # CASE B: BLOCK (Isolated)
        $output .= "\n\n\$\$\n$math\n\$\$\n\n";
    }

    $last_pos = $end_pos;
}

# Append remaining text
$output .= substr($content, $last_pos);

# Phase 4: Idempotency Guard & Final Polish
$output =~ s/\r\n/\n/g;
$output =~ s/[ \t]+\n/\n/g;
$output =~ s/\n{3,}/\n\n/g;
$output =~ s/^\n+//;
$output =~ s/\n+$/\n/;

print $output;
