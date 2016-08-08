using System;
using System.Collections.Generic;
using System.Linq;
//using System.Text;
//using System.Threading.Tasks;
using UnityEngine;

namespace RetractableLiftingSurface
{
    public class RetractableLiftingSurface : ModuleLiftingSurface
    {
        [KSPField(isPersistant = true, guiActive = false, guiActiveEditor = false)]
        public float retractedDeflectionLiftCoeff = 0.0F;

        [KSPField(isPersistant = true, guiActive = false, guiActiveEditor = false)]
        public float extendedDeflectionLiftCoeff = 1.0F;

        [KSPField(isPersistant = true, guiActive = false, guiActiveEditor = false)]
        public int retracted = 1;


        [KSPField(isPersistant = true, guiActive = false, guiActiveEditor = false)]
        public float retractedCtlSfcDeflectionLiftCoeff = 0.0F;

        [KSPField(isPersistant = true, guiActive = false, guiActiveEditor = false)]
        public float extendedCtlSfcDeflectionLiftCoeff = 1.0F;



        const string modName = "RetractableLiftingSurface";

        // the animation for the retractable lifting surface (ie: folding wings)
        private ModuleAnimateGeneric deployAnimation;

        // an integrated control surface, if needed
        private ModuleControlSurface controlSurface;


        public override void OnStart(StartState state)
        {
            deployAnimation = GetDeployAnimation();
            controlSurface = GetControlSurface();

            base.OnStart(state);
        }

        public void LateUpdate()
        {
            float m;
            if (retracted == 0)
            {
                m = deployAnimation.animTime;
            }
            else
            {
                m = 1.0f - deployAnimation.animTime;
            }
            if (controlSurface != null)
                controlSurface.deflectionLiftCoeff = (extendedCtlSfcDeflectionLiftCoeff - retractedCtlSfcDeflectionLiftCoeff) * m + retractedCtlSfcDeflectionLiftCoeff;
            
            deflectionLiftCoeff = (extendedDeflectionLiftCoeff - retractedDeflectionLiftCoeff) * m + retractedDeflectionLiftCoeff;
        }

        private ModuleAnimateGeneric GetDeployAnimation()
        {
            ModuleAnimateGeneric myAnimation = null;

            try
            {
                myAnimation = part.FindModulesImplementing<ModuleAnimateGeneric>().SingleOrDefault();
            }
            catch (System.Exception x)
            {
                Debug.Log(string.Format("{0} ERROR: {1}", modName, x.Message));
            }

            return myAnimation;
        }

        private ModuleControlSurface GetControlSurface()
        {
            ModuleControlSurface myControlSurface = null;

            myControlSurface = part.FindModulesImplementing<ModuleControlSurface>().SingleOrDefault();

            return myControlSurface;
        }
    }
}
