# Screening for fungal neuromodulatory genes through horizontal gene transfer discovery

This respository documents the code that was run as part of the pub, ["Potential neuromodulatory genes identified through a discovery pipeline that screens for horizontal gene transfer events"](https://doi.org/10.57844/arcadia-jqq0-y385).

We ran the [prehgt](https://github.com/Arcadia-Science/prehgt) pipeline on Nextflow [Tower](https://tower.nf) (Nextflow version 23.04.2 build 5870).
We documented the run information in the following files:
* [`run_prehgt.sh`](./run_prehgt.sh): The Nextflow command used to execute the pipeline. We ran the pipeline from a specific commit, but it is essentially the same as running the pipeline from the first release (other code changes integrated after this commit did not impact the runtime behavior of the Nextflow pipeline).
* [`config_info.md`](./config_info.md): Configuration information for the pipeline run.
* [`params.txt`](./params.txt): Parameter information for the pipeline run.

Many of the input files were hosted on S3.
We provide public links to the files in the file [`public_file_links.md`](./public_file_links.md).

The results from the pipeline are available in the [results](./results) folder.
* [`results_filtered.tsv`](./results/results_filtered.tsv): records the HGT candidates output by the prehgt pipeline. 
* [`genomes/*csv`](./results/genomes): records the genomes analyzed by the pipeline.
* [`neuromodulatory_candidate_gffs/*gff`](./results/neuromodulatory_candidate_gffs/): contains annotation information in GFF format for three HGT candidate genes with predicted function relevant to neuromodulation. These events are described in detail in the [pub](https://doi.org/10.57844/arcadia-jqq0-y385).
