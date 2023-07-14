# Configuration information

## Configuration files

* /.nextflow/assets/Arcadia-Science/prehgt/nextflow.config
* /nextflow.config

## Resolved configuration

```
params {
   input = 's3://arcadia-rehgt/input/neuromod_fungi.tsv'
   blast_db = 's3://software-databases/clustered-nr/nr_rep_seq.fasta.gz'
   blast_db_tax = 's3://software-databases/clustered-nr/nr_cluster_taxid_formatted_final.sqlite'
   ko_list = 's3://software-databases/kofamscan/ko_list.gz'
   ko_profiles = 's3://software-databases/kofamscan/profiles.tar.gz'
   hmm_db = 's3://software-databases/custom_hmms/all_hmms.hmm'
   padj = 0.01
   outdir = 's3://arcadia-rehgt/output/'
   email = 'taylor.reiter@arcadiascience.com'
   custom_config_version = 'master'
   custom_config_base = 'https://raw.githubusercontent.com/nf-core/configs/master'
   max_cpus = 144
   max_memory = '384.GB'
   max_time = '240.h'
   help = false
   publish_dir_mode = 'copy'
   plaintext_email = false
   monochrome_logs = false
   tracedir = '${params.outdir}/pipeline_info'
   validate_params = true
   show_hidden_params = false
   email_on_fail = null
   hook_url = null
   schema_ignore_params = 'config_profile_name,config_profile_url,config_profile_contact,config_profile_description,custom_config_base,custom_config_version,genomes,hook_url'
   config_profile_description = null
   config_profile_contact = null
   config_profile_url = null
   config_profile_name = null
}

process {
   cpus = { check_max( 1    * task.attempt, 'cpus'   ) }
   memory = { check_max( 6.GB * task.attempt, 'memory' ) }
   time = { check_max( 4.h  * task.attempt, 'time'   ) }
   errorStrategy = { task.exitStatus in [143,137,104,134,139] ? 'retry' : 'finish' }
   maxRetries = 3
   maxErrors = '-1'
   withLabel:process_single {
      cpus = { check_max( 1                  , 'cpus'    ) }
      memory = { check_max( 6.GB * task.attempt, 'memory'  ) }
      time = { check_max( 4.h  * task.attempt, 'time'    ) }
   }
   withLabel:process_low {
      cpus = { check_max( 2     * task.attempt, 'cpus'    ) }
      memory = { check_max( 12.GB * task.attempt, 'memory'  ) }
      time = { check_max( 4.h   * task.attempt, 'time'    ) }
   }
   withLabel:process_medium {
      cpus = { check_max( 6     * task.attempt, 'cpus'    ) }
      memory = { check_max( 36.GB * task.attempt, 'memory'  ) }
      time = { check_max( 8.h   * task.attempt, 'time'    ) }
   }
   withLabel:process_high {
      cpus = { check_max( 12    * task.attempt, 'cpus'    ) }
      memory = { check_max( 72.GB * task.attempt, 'memory'  ) }
      time = { check_max( 16.h  * task.attempt, 'time'    ) }
   }
   withLabel:process_long {
      time = { check_max( 20.h  * task.attempt, 'time'    ) }
   }
   withLabel:process_high_memory {
      memory = { check_max( 200.GB * task.attempt, 'memory' ) }
   }
   withLabel:error_ignore {
      errorStrategy = 'ignore'
   }
   withLabel:error_retry {
      errorStrategy = 'retry'
      maxRetries = 2
   }
   withLabel:with_gpus {
      maxForks = 1
      containerOptions = { workflow.containerEngine == "singularity" ? '--nv':
        ( workflow.containerEngine == "docker" ? '--gpus all': null ) }
   }
   withLabel:process_high_cpu {
      cpus = { check_max( 16     * task.attempt, 'cpus'    ) }
      memory = { check_max( 32.GB  * task.attempt, 'memory'  ) }
      time = { check_max( 24.h   * task.attempt, 'time'    ) }
   }
   shell = ['/bin/bash', '-euo', 'pipefail']
   publishDir = [path:{ "${params.outdir}/${task.process.tokenize(':')[-1].tokenize('_')[0].toLowerCase()}" }, mode:'copy', saveAs:{ filename -> filename.equals('versions.yml') ? null : filename }]
   executor = 'awsbatch'
   queue = 'TowerForge-jGdu43p5DPG7RRotXrlO1-work'
}

mail {
   smtp {
      host = null
      port = null
      user = null
      password = '[secret]'
      ssl {
         protocols = 'TLSv1.2'
      }
      auth = true
      starttls {
         enable = true
         required = true
      }
   }
}

env {
   PYTHONNOUSERSITE = 1
   R_PROFILE_USER = '/.Rprofile'
   R_ENVIRON_USER = '/.Renviron'
   JULIA_DEPOT_PATH = '/usr/local/share/julia'
}

timeline {
   enabled = true
   file = 'timeline-4bJCq3DaIgeAD1.html'
}

report {
   enabled = true
   file = '${params.outdir}/pipeline_info/execution_report_2023-07-12_15-55-06.html'
}

trace {
   enabled = true
   file = '${params.outdir}/pipeline_info/execution_trace_2023-07-12_15-55-06.txt'
}

dag {
   enabled = true
   file = '${params.outdir}/pipeline_info/pipeline_dag_2023-07-12_15-55-06.html'
}

manifest {
   name = 'Arcadia-Science/prehgt'
   author = 'Arcadia Science'
   homePage = 'https://github.com/Arcadia-Science/prehgt'
   description = 'generating a preliminary list of HGT candidates using compositional and phylogenetic implicit approaches'
   mainScript = 'main.nf'
   nextflowVersion = '!>=21.10.3'
   version = '1.0dev'
   doi = ''
}

docker {
   enabled = true
   userEmulation = true
}

singularity {
   enabled = false
}

podman {
   enabled = false
}

shifter {
   enabled = false
}

charliecloud {
   enabled = false
}

conda {
   enabled = false
}

aws {
   region = 'us-west-1'
   client {
      uploadChunkSize = 10485760
   }
   batch {
      cliPath = '/home/ec2-user/miniconda/bin/aws'
      executionRole = 'arn:aws:iam::943220452459:role/TowerForge-jGdu43p5DPG7RRotXrlO1-ExecutionRole'
   }
}

workDir = 's3://arcadia-rehgt/scratch/8E0xtuJ2kigSg'
runName = 'emilys_fungi_6'
resume = 'a913f621-d5c5-4410-916f-9568c783329e'

tower {
   enabled = true
   endpoint = 'https://api.tower.nf'
}
```
