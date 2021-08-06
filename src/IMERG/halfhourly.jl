struct IMERGHalfHourly{ST<:AbstractString, DT<:TimeType} <: IMERGDataset
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

function IMERGEarlyHH(
    ST = String,
    DT = Date;
    dtbeg :: TimeType,
    dtend :: TimeType,
    sroot :: AbstractString,
)

	@info "$(now()) - NASAPrecipitation.jl - Setting up data structure containing information on Early IMERG Half-Hourly data to be downloaded"

    fol = joinpath(sroot,"imergearlyhh"); if !isdir(fol); mkpath(fol) end

    return IMERGHalfHourly{ST,DT}(
		"imergearlyhh", "Early IMERG Half-Hourly", "10.5067/GPM/IMERG/3B-HH-E/06",
        dtbeg, dtend,
		joinpath(sroot,"imergearlyhh"),
        "https://gpm1.gesdisc.eosdis.nasa.gov/opendap/GPM_L3/GPM_3IMERGHHE.06",
        "3B-HHR-E.MS.MRG.3IMERG", "V06B.HDF5",
    )

end

function IMERGLateHH(
    ST = String,
    DT = Date;
    dtbeg :: TimeType,
    dtend :: TimeType,
    sroot :: AbstractString,
)

	@info "$(now()) - NASAPrecipitation.jl - Setting up data structure containing information on Late IMERG Half-Hourly data to be downloaded"

    fol = joinpath(sroot,"imerglatehh"); if !isdir(fol); mkpath(fol) end

    return IMERGHalfHourly{ST,DT}(
		"imerglatehh", "Late IMERG Half-Hourly", "10.5067/GPM/IMERG/3B-HH-L/06",
        dtbeg, dtend,
		joinpath(sroot,"imerglatehh"),
        "https://gpm1.gesdisc.eosdis.nasa.gov/opendap/GPM_L3/GPM_3IMERGHHL.06",
        "3B-HHR-L.MS.MRG.3IMERG", "V06B.HDF5",
    )

end

function IMERGFinalHH(
    ST = String,
    DT = Date;
    dtbeg :: TimeType,
    dtend :: TimeType,
    sroot :: AbstractString,
)

	@info "$(now()) - NASAPrecipitation.jl - Setting up data structure containing information on Final IMERG Half-Hourly data to be downloaded"

    fol = joinpath(sroot,"imergfinalhh"); if !isdir(fol); mkpath(fol) end

    return IMERGHalfHourly{ST,DT}(
		"imergfinalhh", "Final IMERG Half-Hourly", "10.5067/GPM/IMERG/3B-HH/06",
        dtbeg, dtend,
		joinpath(sroot,"imergfinalhh"),
        "https://gpm1.gesdisc.eosdis.nasa.gov/opendap/GPM_L3/GPM_3IMERGHH.06",
        "3B-HHR.MS.MRG.3IMERG", "V06B.HDF5",
    )

end

function show(io::IO, npd::IMERGHalfHourly{ST,DT}) where {ST<:AbstractString, DT<:TimeType}
    print(
		io,
		"The NASA Precipitation Dataset {$ST,$DT} has the following properties:\n",
		"    Dataset ID      (npdID) : ", npd.npdID, '\n',
		"    Logging Name    (lname) : ", npd.lname, '\n',
		"    DOI URL          (doi)  : ", npd.doi,   '\n',
		"    Data Directory  (sroot) : ", npd.sroot, '\n',
		"    Date Begin      (dtbeg) : ", npd.dtbeg, '\n',
		"    Date End        (dtend) : ", npd.dtend, '\n',
		"    Timestep                : 30 minutes\n",
        "    Data Resolution         : 0.1º\n",
        "    Data Server     (hroot) : ", npd.hroot, '\n',
	)
end