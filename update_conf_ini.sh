#!/bin/bash

# Connect to machine via ssh
# Change conf.ini
	# output_filename = impacters_engie_vasgos_v11-8 -> v12-0
	# stages_range = 5- -> 1-
	# break_docs = True -> False


# pipeline-update-1
ssh ubuntu@<IP> <<'ENDSSH'

	projects=("VALECO_BOISSY_20200609/impacters-pipeline"
			  "ENGIE_VASGOS_07092020/pipeline"
			  "ENGIE_HAUTE_LYS_10092020/impacters-pipeline"
			  "EDPR_Raillimont_05102020/impacters-pipeline")

	for project in "${projects[@]}"
	do
		cd "$project"/config

		sed -i -r -e '
		s/(.*)v([0-9]+)-[0-9]+/echo "\1v$((\2+1))-0"/e
		/export/,/save/ s/stages_range = [0-9]*/stages_range = 1/
		/long/,/break_number/ s/break_docs = True/break_docs = False/' conf.ini

		cd ~
	done

	exit

ENDSSH


# tmp-prod-3
ssh ubuntu@<IP> <<'ENDSSH'

	projects=("EUROVIA_BTP_EVENOS_20200612"
			  "EUROVIA_BTP_POURCIEUX_20200630")

	for project in "${projects[@]}"
	do
		cd "$project"/impacters-pipeline/config

		sed -i -r -e '
		s/(.*)v([0-9]+)-[0-9]+/echo "\1v$((\2+1))-0"/e
		/export/,/save/ s/stages_range = [0-9]*/stages_range = 1/
		/long/,/break_number/ s/break_docs = True/break_docs = False/' conf.ini

		cd ~
	done

	exit

ENDSSH