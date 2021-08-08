using NASAPrecipitation
using Documenter

makedocs(;
    modules  = [NASAPrecipitation],
    doctest  = false,
    format   = Documenter.HTML(collapselevel=1,prettyurls=false),
    authors  = "Nathanael Wong <natgeo.wong@outlook.com>",
    sitename = "NASAPrecipitation.jl",
    pages    = [
        "Home"                        => "index.md",
        "Dataset Basics" => [
            "NASA Precipitation Datasets" => "datasets/npd.md",
            "GPM IMERG Datasets"          => "datasets/imerg.md",
            "TRMM TMPA Datasets"          => "datasets/trmm.md",
            "Land-Sea Mask Datasets"      => "datasets/landseamask.md",
        ],
        "Downloading Data" => [
            "Download APIs and Examples" => "download/download.md",
            "A Basic Primer to `GeoRegion`s" => "download/georegions.md",
        ],
    ],
)

deploydocs(
    repo = "github.com/natgeo-wong/NASAPrecipitation.jl.git",
    devbranch = "main"
)
