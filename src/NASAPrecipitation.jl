module NASAPrecipitation

## Modules Used
using Logging
using NCDatasets
using Printf
using Statistics

## Reexporting exported functions within these modules
using Reexport
@reexport using Dates
@reexport using GeoRegions

import Base: download, show

## Exporting the following functions:
export
        IMERGFinalHH, IMERGLateHH, IMERGEarlyHH,
        IMERGFinalDY, IMERGLateDY, IMERGEarlyDY,
        IMERGMonthly,

        TRMM3Hourly, TRMM3HourlyNRT,
        TRMMDaily,   TRMMDailyNRT,
        TRMMMonthly,

        getIMERGlsm, getTRMMlsm, addNPDGeoRegions

        download

## Abstract types
"""
    NASAPrecipitationDataset{ST<:AbstractString, DT<:TimeType}
        npdID :: ST
        lname :: ST
        doi   :: ST
        dtbeg :: DT
        dtend :: DT
        sroot :: ST
        hroot :: ST
        fpref :: ST
        fsuff :: ST
    end

Abstract supertype for NASA Precipitation datasets on NASA OPeNDAP Servers.

Fields:
* `npdID` : ID for the `NASAPrecipitationDataset`, used in determining containing folders and filenames of the NetCDF
* `lname` : The name describing the `NASAPrecipitationDataset`, used mostly in Logging
* `doi`   : The DOI identifier, to be saved into the NetCDF
* `dtbeg` : The start date (Y,M,D) of our download / analysis
* `dtend` : The end date (Y,M,D) of our download / analysis
* `sroot` : The directory in which to save our downloads and analysis files to
* `hroot` : The URL of the NASA's EOSDIS OPeNDAP server for which this dataset is stored
* `fpref` : The prefix component of the NetCDF files to be downloaded
* `fsuff` : The suffix component of the NetCDF files to be downloaded

Of these fields, only `dtbeg`, `dtend` and `sroot` are user-defined.  All other fields are predetermined depending on the type of NASA Precipitation Dataset called.
"""
abstract type NASAPrecipitationDataset end

"""
    IMERGDataset <: NASAPrecipitationDataset

Abstract supertype for GPM IMERG datasets on NASA OPeNDAP Servers, a subType of `NASAPrecipitationDataset`.
"""
abstract type IMERGDataset <: NASAPrecipitationDataset end

"""
    TRMMDataset <: NASAPrecipitationDataset

Abstract supertype for TRMM TMPA datasets on NASA OPeNDAP Servers, a subType of `NASAPrecipitationDataset`.
"""
abstract type TRMMDataset  <: NASAPrecipitationDataset end

function __init__()
    @info "$(now()) - NASAPrecipitation.jl - Checking to see if GeoRegions required by NASAPrecipitation.jl have been added to the list of available GeoRegions"
    disable_logging(Logging.Warn)
	if !isGeoRegion("IMERG",throw=false) ||
	    !isGeoRegion("TRMM",throw=false) ||
	    !isGeoRegion("TRMMLSM",throw=false)
        disable_logging(Logging.Debug)
        @info "$(now()) - NASAPrecipitation.jl - At least one of the required three GeoRegions (IMERG, TRMM, TRMMLSM) has not been added, proceeding to add them again ..."
        disable_logging(Logging.Warn)
	    addGeoRegions(joinpath(@__DIR__,"NPDGeoRegions.txt"))
    else
        disable_logging(Logging.Debug)
        @info "$(now()) - NASAPrecipitation.jl - All of the required three GeoRegions (IMERG, TRMM, TRMMLSM) have been added"
        disable_logging(Logging.Warn)
	end
    disable_logging(Logging.Debug)
end

## Including Relevant Files

include("IMERG/halfhourly.jl")
include("IMERG/daily.jl")
include("IMERG/monthly.jl")
include("IMERG/landseamask.jl")

include("TRMM/3hourly.jl")
include("TRMM/daily.jl")
include("TRMM/monthly.jl")
include("TRMM/landseamask.jl")

include("downloads.jl")
include("save.jl")
include("backend.jl")

end