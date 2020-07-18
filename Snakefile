prefix = "1"
chr="1"

rule plink:
    input:
        file="../Data/{prefix}.txt",
    output:
        ped="{prefix}_{chr}.ped",
        map="{prefix}_{chr}.map"
    shell:
        "plink --23file {input} --output-chr M --chr {chr} --make-bed --recode ped --out {prefix}_{chr}"

rule germline:
    input:
        ped="{prefix}_{chr}.ped",
        map="{prefix}_{chr}.map"
    output:
        "{prefix}_{chr}.ger.match"
    shell:
        "../germline-1-5-3/germline -input {input.ped} {input.map} -homoz -min_m 2.5 -err_hom 2 -err_het 1 -output {prefix}_{chr}.ger || true"