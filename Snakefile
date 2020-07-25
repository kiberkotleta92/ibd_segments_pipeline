rule plink:
    input:
        file="../Data/{prefix}.txt",
    output:
        ped="ped/{prefix}_{chr}.ped",
        map="map/{prefix}_{chr}.map"
    shell:
        "plink --23file {input} --output-chr M --chr {wildcards.chr} --recode ped --out {wildcards.prefix}_{wildcards.chr}; "
        "mv {wildcards.prefix}_{wildcards.chr}.ped ped/{wildcards.prefix}_{wildcards.chr}.ped || true; "
        "mv {wildcards.prefix}_{wildcards.chr}.map map/{wildcards.prefix}_{wildcards.chr}.map || true"

rule germline:
    input:
        ped="ped/{prefix}_{chr}.ped",
        map="map/{prefix}_{chr}.map"
    output:
        "match/{prefix}_{chr}.ger.match"
    shell:
        "../germline-1-5-3/germline -input {input.ped} {input.map} -homoz "
        "-min_m 2.5 -err_hom 2 -err_het 1 -output {wildcards.prefix}_{wildcards.chr}.ger || true; "
        "mv {wildcards.prefix}_{wildcards.chr}.ger.match match/{wildcards.prefix}_{wildcards.chr}.ger.match"

rule concat:
    input:
        lambda wildcards: [f"match/{wildcards.prefix}_{chr}.ger.match" for chr in list(range(1, 24)) + ["X"]]
    output:
        "{prefix}.result"
    shell:
        "cat {input} >> {output}; "
        "mkdir logs; mv *log logs/"