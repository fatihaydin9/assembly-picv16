#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/LUNAPARK_PROTEUS_NO_INT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/LUNAPARK_PROTEUS_NO_INT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=lunapark_no_interrupt.asm

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/lunapark_no_interrupt.o
POSSIBLE_DEPFILES=${OBJECTDIR}/lunapark_no_interrupt.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/lunapark_no_interrupt.o

# Source Files
SOURCEFILES=lunapark_no_interrupt.asm


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/LUNAPARK_PROTEUS_NO_INT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16f877a
MP_LINKER_DEBUG_OPTION= 
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/lunapark_no_interrupt.o: lunapark_no_interrupt.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/lunapark_no_interrupt.o.d 
	@${RM} ${OBJECTDIR}/lunapark_no_interrupt.o 
	@${FIXDEPS} dummy.d -e "C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.ERR" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_SIMULATOR=1 -q -p$(MP_PROCESSOR_OPTION)  $(ASM_OPTIONS)    \"C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.asm\" 
	@${MV}  C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.O ${OBJECTDIR}/lunapark_no_interrupt.o
	@${MV}  C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.ERR ${OBJECTDIR}/lunapark_no_interrupt.o.err
	@${MV}  C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.LST ${OBJECTDIR}/lunapark_no_interrupt.o.lst
	@${RM}  C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.HEX 
	@${DEP_GEN} -d "${OBJECTDIR}/lunapark_no_interrupt.o"
	@${FIXDEPS} "${OBJECTDIR}/lunapark_no_interrupt.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
else
${OBJECTDIR}/lunapark_no_interrupt.o: lunapark_no_interrupt.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/lunapark_no_interrupt.o.d 
	@${RM} ${OBJECTDIR}/lunapark_no_interrupt.o 
	@${FIXDEPS} dummy.d -e "C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.ERR" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  $(ASM_OPTIONS)    \"C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.asm\" 
	@${MV}  C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.O ${OBJECTDIR}/lunapark_no_interrupt.o
	@${MV}  C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.ERR ${OBJECTDIR}/lunapark_no_interrupt.o.err
	@${MV}  C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.LST ${OBJECTDIR}/lunapark_no_interrupt.o.lst
	@${RM}  C:/Users/fatay/MPLABXProjects/LUNAPARK_PROTEUS_NO_INT.X/lunapark_no_interrupt.HEX 
	@${DEP_GEN} -d "${OBJECTDIR}/lunapark_no_interrupt.o"
	@${FIXDEPS} "${OBJECTDIR}/lunapark_no_interrupt.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/LUNAPARK_PROTEUS_NO_INT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w -x -u_DEBUG -z__ICD2RAM=1 -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"   -z__MPLAB_BUILD=1  -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_SIMULATOR=1 $(MP_LINKER_DEBUG_OPTION) -odist/${CND_CONF}/${IMAGE_TYPE}/LUNAPARK_PROTEUS_NO_INT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
else
dist/${CND_CONF}/${IMAGE_TYPE}/LUNAPARK_PROTEUS_NO_INT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w  -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"   -z__MPLAB_BUILD=1  -odist/${CND_CONF}/${IMAGE_TYPE}/LUNAPARK_PROTEUS_NO_INT.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
