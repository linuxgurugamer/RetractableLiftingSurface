This is a small module which allows you to have a folding wing or other retractable lifting surface.  It allows for an integrated control surface (only one at this time).

Additionally, the integrated control surface is eased in once the wing is deployed, so that it doesn't kick in instantly

Instructions for use:

Add the following module to the cfg file ( which replaces the ModuleLiftingSurface):

    MODULE
    {
        name = RetractableLiftingSurface
        retracted = 1     // this value comes from the animation  If you find that you are getting
                        // lift when retracted, and no lift when extended, set this to 0
        retractedDeflectionLiftCoeff = 0
        extendedDeflectionLiftCoeff = 1.37 // 4.83m^
        useInternalDragModel = True

        // If no control surface as part of this lifting surface, then no need for
        // following two lines
        retractedCtlSfcDeflectionLiftCoeff = 0
        extendedCtlSfcDeflectionLiftCoeff = 1.25
    }
