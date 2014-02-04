BT=${BT-/usr/bin/bedtools}

check()
{
	if diff $1 $2; then
    	echo ok
	else
    	echo fail
	fi
}

###########################################################
#  Test intersection of a as bed from file vs b as bed from file
############################################################
echo "    intersect.new.t01...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a a.bed -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as bed from redirect vs b as bed from file
############################################################
echo "    intersect.new.t02...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a - -b b.bed < a.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as bed from pipe vs b as bed from file
############################################################
echo "    intersect.new.t03...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
cat a.bed | $BT intersect -a - -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as bed from fifo vs b as bed from file
############################################################
echo "    intersect.new.t04...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a <(cat a.bed) -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as gzipped from file vs b as bed from file
############################################################
echo "    intersect.new.t05...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a a_gzipped.bed.gz -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as gzipped from redirect vs b as bed from file
############################################################
echo "    intersect.new.t06...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a - -b b.bed < a_gzipped.bed.gz > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as gzipped from pipe vs b as bed from file
############################################################
echo "    intersect.new.t07...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
cat a_gzipped.bed.gz | $BT intersect -a - -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as gzipped from fifo vs b as bed from file
############################################################
echo "    intersect.new.t08...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a <(cat a_gzipped.bed.gz) -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as bgzipped from file vs b as bed from file
############################################################
echo "    intersect.new.t09...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a a_bgzipped.bed.gz -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as bgzipped from redirect vs b as bed from file
############################################################
echo "    intersect.new.t10...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a - -b b.bed < a_bgzipped.bed.gz > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as bgzipped from pipe vs b as bed from file
############################################################
echo "    intersect.new.t11...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
cat a_bgzipped.bed.gz | $BT intersect -a - -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as bgzipped from fifo vs b as bed from file
############################################################
echo "    intersect.new.t12...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a <(cat a_bgzipped.bed.gz) -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a as bam from file vs b as bed from file
############################################################
echo "    intersect.new.t13...\c"
$BT intersect -a a.bam -b b.bed> obs
check obs aVSb.bam
rm obs


###########################################################
#  Test intersection of a as bam from redirect vs b as bed from file
############################################################
echo "    intersect.new.t14...\c"
$BT intersect -a - -b b.bed < a.bam> obs
check obs aVSb.bam
rm obs


###########################################################
#  Test intersection of a as bam from pipe vs b as bed from file
############################################################
echo "    intersect.new.t15...\c"
cat a.bam | $BT intersect -a - -b b.bed> obs
check obs aVSb.bam
rm obs


###########################################################
#  Test intersection of a as bam from fifo vs b as bed from file
############################################################
echo "    intersect.new.t16...\c"
$BT intersect -a <(cat a.bam) -b b.bed > obs
check obs aVSb.bam
rm obs


###########################################################
#  Test intersection of bam file containing both good reads
#  and those where both read and mate are unmapped vs b file
#  as bed.
############################################################
echo "    intersect.new.t17...\c"
echo \
"chr1	100	101	a2	255	-	100	200	0,0,0	1	100,	0,
chr1	100	110	a2	255	-	100	200	0,0,0	1	100,	0," > exp
$BT intersect -a a_with_bothUnmapped.bam -b b.bed -bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of bam file containing both good reads
#  and those where both read and mate are unmapped vs b file
#  as bed, with noHit (-v) option. 
############################################################
echo "    intersect.new.t18...\c"
echo \
"chr1	10	20	a1	255	+	10	20	0,0,0	1	10,	0,
.	-1	-1	FCC1MK2ACXX:1:1101:5780:51632#/1	0	.	-1	-1	-1	0,0,0	0	.	.
.	-1	-1	FCC1MK2ACXX:1:1101:5780:51632#/2	0	.	-1	-1	-1	0,0,0	0	.	.
.	-1	-1	FCC1MK2ACXX:1:1101:8137:99409#/1	0	.	-1	-1	-1	0,0,0	0	.	.
.	-1	-1	FCC1MK2ACXX:1:1101:8137:99409#/2	0	.	-1	-1	-1	0,0,0	0	.	.
.	-1	-1	FCC1MK2ACXX:1:1102:6799:2633#/1	0	.	-1	-1	-1	0,0,0	0	.	.
.	-1	-1	FCC1MK2ACXX:1:1102:6799:2633#/2	0	.	-1	-1	-1	0,0,0	0	.	." > exp
$BT intersect -a a_with_bothUnmapped.bam -b b.bed -bed -v > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of bam file containing read where one
# mate is mapped and one is not.
############################################################
echo "    intersect.new.t19...\c"
echo \
"chr1	98650	98704	FCC1MK2ACXX:1:1212:13841:9775#/1	0	+	98604	98704	0,0,0	1	100,	0," > exp
$BT intersect -a oneUnmapped.bam -b j1.bed -bed > obs
check obs exp
rm obs exp

###########################################################
#  Test intersection of bam file containing read where one
# mate is mapped and one is not, with noHit (-v) option.
############################################################
echo "    intersect.new.t20...\c"
echo \
"chr1	-1	-1	FCC1MK2ACXX:1:1212:13841:9775#/2	0	.	-1	-1	-1	0,0,0	0	.	." > exp
$BT intersect -a oneUnmapped.bam -b j1.bed -bed -v > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection with -sorted, see that order specified
#  in genome file is enforced.
############################################################
echo "    intersect.new.t21...\c"
echo \
"Error: Sorted input specified, but the file chromOrderA.bed has the following record with a different sort order than the genomeFile human.hg19.genome
chr10	10	20	a3	100	+" > exp
$BT intersect -a chromOrderA.bed -b chromOrderB.bed -sorted -g human.hg19.genome 2>obs
check obs exp
rm obs exp


###########################################################
#  Test intersection with -sorted, see that hits are missed
#  With no genome file
############################################################
echo "    intersect.new.t22...\c"
echo \
"chr1	15	20	a1	100	+
chr2	15	20	a2	100	+
chrX	15	20	a5	100	+" > exp
$BT intersect -a chromOrderA.bed -b chromOrderB.bed -sorted > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection with -sorted, see that hits are correct
#  when sort order of files matches genome file sort order
############################################################
echo "    intersect.new.t23...\c"
echo \
"chr1	15	20	a1	100	+
chr2	15	20	a2	100	+
chr10	15	20	a3	100	+
chr11	15	20	a4	100	+
chrX	15	20	a5	100	+
chrM	15	20	a6	100	+" > exp
$BT intersect -a chromOrderA.bed -b chromOrderB.bed -sorted -g human.hg19.vSort.genome > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as bed from file vs b as bed from file
############################################################
echo "    intersect.new.t24...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a a_withLargeHeader.bed -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as bed from redirect vs b as bed from file
############################################################
echo "    intersect.new.t25...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a - -b b.bed < a_withLargeHeader.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as bed from pipe vs b as bed from file
############################################################
echo "    intersect.new.t26...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
cat a_withLargeHeader.bed | $BT intersect -a - -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as bed from fifo vs b as bed from file
############################################################
echo "    intersect.new.t27...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a <(cat a_withLargeHeader.bed) -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as gzipped from file vs b as bed from file
############################################################
echo "    intersect.new.t28...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a a_withLargeHeader_gzipped.bed.gz -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as gzipped from redirect vs b as bed from file
############################################################
echo "    intersect.new.t29...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a - -b b.bed < a_withLargeHeader_gzipped.bed.gz > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as gzipped from pipe vs b as bed from file
############################################################
echo "    intersect.new.t30...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
cat a_withLargeHeader_gzipped.bed.gz | $BT intersect -a - -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as gzipped from fifo vs b as bed from file
############################################################
echo "    intersect.new.t31...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a <(cat a_withLargeHeader_gzipped.bed.gz) -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as bgzipped from file vs b as bed from file
############################################################
echo "    intersect.new.t32...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a a_withLargeHeader_bgzipped.bed.gz -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as bgzipped from redirect vs b as bed from file
############################################################
echo "    intersect.new.t33...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a - -b b.bed < a_withLargeHeader_bgzipped.bed.gz > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as bgzipped from pipe vs b as bed from file
############################################################
echo "    intersect.new.t34...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
cat a_withLargeHeader_bgzipped.bed.gz | $BT intersect -a - -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as bgzipped from fifo vs b as bed from file
############################################################
echo "    intersect.new.t35...\c"
echo \
"chr1	100	101	a2	2	-
chr1	100	110	a2	2	-" > exp
$BT intersect -a <(cat a_withLargeHeader_bgzipped.bed.gz) -b b.bed > obs
check obs exp
rm obs exp


###########################################################
#  Test intersection of a with large header as bed from file 
#  vs b as bed from file, and print header
############################################################
echo "    intersect.new.t36...\c"
$BT intersect -a a_withLargeHeader.bed -b b.bed -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as bed from 
#  redirect vs b as bed from file, and print header
############################################################
echo "    intersect.new.t37...\c"
$BT intersect -a - -b b.bed < a_withLargeHeader.bed -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as bed from pipe
#  vs b as bed from file, and print header
############################################################
echo "    intersect.new.t38...\c"
cat a_withLargeHeader.bed | $BT intersect -a - -b b.bed -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as bed from fifo
#  vs b as bed from file, and print header
############################################################
echo "    intersect.new.t39...\c"
$BT intersect -a <(cat a_withLargeHeader.bed) -b b.bed -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as gzipped from
#  file vs b as bed from file, and print header
############################################################
echo "    intersect.new.t40...\c"
$BT intersect -a a_withLargeHeader_gzipped.bed.gz -b b.bed -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as gzipped from
#  redirect vs b as bed from file, and print header
############################################################
echo "    intersect.new.t41...\c"
$BT intersect -a - -b b.bed < a_withLargeHeader_gzipped.bed.gz -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as gzipped from
#  pipe vs b as bed from file, and print header
############################################################
echo "    intersect.new.t42...\c"
cat a_withLargeHeader_gzipped.bed.gz | $BT intersect -a - -b b.bed -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as gzipped from
#  fifo vs b as bed from file, and print header
############################################################
echo "    intersect.new.t43...\c"
$BT intersect -a <(cat a_withLargeHeader_gzipped.bed.gz) -b b.bed -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as bgzipped from
#  file vs b as bed from file, and print header
############################################################
echo "    intersect.new.t44...\c"
$BT intersect -a a_withLargeHeader_bgzipped.bed.gz -b b.bed -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as bgzipped from
#  redirect vs b as bed from file, and print header
############################################################
echo "    intersect.new.t45...\c"
$BT intersect -a - -b b.bed < a_withLargeHeader_bgzipped.bed.gz -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as bgzipped from
#  pipe vs b as bed from file, and print header
############################################################
echo "    intersect.new.t46...\c"
cat a_withLargeHeader_bgzipped.bed.gz | $BT intersect -a - -b b.bed -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test intersection of a with large header as bgzipped from
#  fifo vs b as bed from file, and print header
############################################################
echo "    intersect.new.t47...\c"
$BT intersect -a <(cat a_withLargeHeader_bgzipped.bed.gz) -b b.bed -header > obs
check obs aWithHeaderVsB.txt
rm obs


###########################################################
#  Test enforcement of sort order when using -sorted option.
#  Show that detect chrom "jumping", i.e. chr1, chr2, then
#  back to chr1
############################################################
echo "    intersect.new.t48...\c"
echo "Error: Sorted input specified" > exp
$BT intersect -a chromsOutOfOrder.bed -b b.bed -sorted 2>&1 > /dev/null | grep "Error: Sorted input specified, " | cut -f1 -d ',' > obs
check obs exp
rm obs exp

###########################################################
#  Test enforcement of sort order when using -sorted option.
#  Show that detect chrom "jumping", i.e. chr1, chr2, then
#  back to chr1
############################################################
echo "    intersect.new.t49...\c"
echo "Error: Sorted input specified" > exp
$BT intersect -a recordsOutOfOrder.bed -b b.bed -sorted 2>&1 > /dev/null | grep "Error: Sorted input specified, " | cut -f1 -d ',' > obs
check obs exp
rm obs exp

###########################################################
#  Test that we throw an error for non-existant files
############################################################
echo "    intersect.new.t50...\c"
echo "Error: Unable to open file nonExistantFile.bed. Exiting." > exp
$BT intersect -a nonExistantFile.bed -b b.bed -sorted 2>&1 > /dev/null | cat - >obs
check obs exp
rm obs exp

###########################################################
#  Test that we throw an error for empty files
############################################################
echo "    intersect.new.t51...\c"
echo "is an empty file." > exp
touch dummy.txt
$BT intersect -a dummy.txt -b b.bed 2>&1 > /dev/null | cut -f3-6 -d ' ' > obs
check obs exp
rm obs exp dummy.txt


###########################################################
#  Test that we throw an error for unrecognized arguments
############################################################
echo "    intersect.new.t52...\c"
echo "***** ERROR: Unrecognized parameter: -wrongArg *****" > exp
$BT intersect -a a.bed -b b.bed -wrongArg 2>&1 > /dev/null | head -2 | tail -1 > obs
check obs exp
rm obs exp


###########################################################
#  Test that we can process a Bam file with no text in 
#  it's header. 
############################################################
echo "    intersect.new.t53...\c"
$BT intersect -a gdc.bam -b gdc.bam -bed > obs
check obs gdc_exp
rm obs






