% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter_bam_alignments.R
\name{filter_bam_alignments}
\alias{filter_bam_alignments}
\title{Filter BAM Alignments}
\usage{
filter_bam_alignments(
  df_bam,
  specimen,
  chromosome,
  edit_site_position,
  edit_site_strand,
  allowed_bases_within_gRNA = 3,
  allowed_bases_outside_gRNA = 3
)
}
\arguments{
\item{df_bam}{A data frame containing BAM alignments.}

\item{specimen}{The iGUIDE specimen ID}

\item{chromosome}{The chromosomal loocation of the edit site.}

\item{edit_site_position}{The position of the edit site.}

\item{edit_site_strand}{The strand of thee edit site ('+' or '-').}

\item{allowed_bases_within_gRNA}{The number of base pairs allowed within the gRNA region. Default is 3.}

\item{allowed_bases_outside_gRNA}{The number of base pairs allowed outside the gRNA region. Default is 3.}
}
\value{
A filtered data frame of BAM alignments.
}
\description{
Takes as input a data frame of BAM alignments and filters based on edit site position and strand.
}
\details{
This function filters BAM alignments based on the specified edit site position and strand.
It removes alignments containing soft clipping ('S') or deletions ('D') in the CIGAR string.

The function uses different filtering criteria based on the strand of the edit site:
\itemize{
\item For the '+' strand, alignments are filtered with flag '83', indicating the cut site is to the left of the PAM site.
\item For the '-' strand, alignments are filtered with flag '99', indicating the cut site is to the right of the PAM site.
}

Note: \code{pos} represents the start position of the alignment and is always on the left-hand side of the aligned read,
regardless of the strand it mapped to.

Outputted columns \code{edit_site_min} and \code{edit_site_max} are always relative to the plus strand of the genome. Therefore min is always less than
max regardless of strand being edited and always relative to the plus strand.
}
