/*
 / _____)             _              | |
( (____  _____ ____ _| |_ _____  ____| |__
 \____ \| ___ |    (_   _) ___ |/ ___)  _ \
 _____) ) ____| | | || |_| ____( (___| | | |
(______/|_____)_|_|_| \__)_____)\____)_| |_|
  (C)2013 Semtech-Cycleo

Description:
    Functions used to handle LoRa concentrator radios.

License: Revised BSD License, see LICENSE.TXT file include in the project
Maintainer: Michael Coracin
*/

#ifndef _LORAGW_RADIO_SX1301_H
#define _LORAGW_RADIO_SX1301_H

/* -------------------------------------------------------------------------- */
/* --- DEPENDANCIES --------------------------------------------------------- */

#include <stdint.h>     /* C99 types */
#include <stdbool.h>    /* bool type */

/* -------------------------------------------------------------------------- */
/* --- PUBLIC CONSTANTS ----------------------------------------------------- */

#define SX125x_32MHz_FRAC 15625 /* irreductible fraction for PLL register caculation */

/* -------------------------------------------------------------------------- */
/* --- PUBLIC CONSTANTS ----------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/* --- PUBLIC FUNCTIONS PROTOTYPES ------------------------------------------ */

int lgw_setup_sx125x(uint8_t rf_chain, uint8_t rf_clkout, bool rf_enable, uint8_t rf_radio_type, uint32_t freq_hz);

#endif
/* --- EOF ------------------------------------------------------------------ */
