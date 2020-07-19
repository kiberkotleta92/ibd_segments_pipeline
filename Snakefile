chromosomes = list(range(1, 24)) + ["X", "Y"]

def gen(wildcards):
    return [f"match/{wildcards.prefix}_{chr}.ger.match" for chr in chromosomes]

rule plink:
    input:
        file="../Data/{prefix}.txt",
    output:
        ped="ped/{prefix}_{chr}.ped",
        map="map/{prefix}_{chr}.map"
    shell:
        "plink --23file {input} --output-chr M --chr {wildcards.chr} --recode ped --out {wildcards.prefix}_{wildcards.chr}; "
        "mv {wildcards.prefix}_{wildcards.chr}.ped ped/{wildcards.prefix}_{wildcards.chr}.ped; "
        "mv {wildcards.prefix}_{wildcards.chr}.map map/{wildcards.prefix}_{wildcards.chr}.map"

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
        gen
        #expand("match/{prefix}_{chr}.ger.match", chr=chromosomes)
        # "match/{prefix}_1.ger.match",
        # "match/{prefix}_2.ger.match",
        # "match/{prefix}_3.ger.match",
        # "match/{prefix}_4.ger.match",
        # "match/{prefix}_5.ger.match",
        # "match/{prefix}_6.ger.match",
        # "match/{prefix}_7.ger.match",
        # "match/{prefix}_8.ger.match",
        # "match/{prefix}_9.ger.match",
        # "match/{prefix}_10.ger.match",
        # "match/{prefix}_11.ger.match",
        # "match/{prefix}_12.ger.match",
        # "match/{prefix}_13.ger.match",
        # "match/{prefix}_14.ger.match",
        # "match/{prefix}_15.ger.match",
        # "match/{prefix}_16.ger.match",
        # "match/{prefix}_17.ger.match",
        # "match/{prefix}_18.ger.match",
        # "match/{prefix}_19.ger.match",
        # "match/{prefix}_20.ger.match",
        # "match/{prefix}_21.ger.match",
        # "match/{prefix}_22.ger.match",
        # "match/{prefix}_23.ger.match",
        # "match/{prefix}_X.ger.match",
        # "match/{prefix}_Y.ger.match"
    output:
        "{prefix}.result"
    shell:
        "cat {input} >> {output}; "
        "mkdir logs; mv *log logs/"