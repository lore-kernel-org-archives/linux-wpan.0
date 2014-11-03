Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47883 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbaKCUla (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Nov 2014 15:41:30 -0500
Date: Mon, 3 Nov 2014 23:41:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ieee802154: add extended address validation helper
Message-ID: <20141103204113.GA32352@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org

Hello Alexander Aring,

The patch cb904b0a1630: "ieee802154: add extended address validation
helper" from Nov 2, 2014, leads to the following static checker
warning:

	include/linux/ieee802154.h:212 ieee802154_is_valid_extended_addr()
	warn: was && intended here instead of ||?

include/linux/ieee802154.h
   201  /**
   202   * ieee802154_is_valid_psdu_len - check if extended addr is valid
   203   * @addr: extended addr to check
   204   */
   205  static inline bool ieee802154_is_valid_extended_addr(const __le64 addr)
   206  {
   207          /* These EUI-64 addresses are reserved by IEEE. 0xffffffffffffffff
   208           * is used internally as extended to short address broadcast mapping.
   209           * This is currently a workaround because neighbor discovery can't
   210           * deal with short addresses types right now.
   211           */
   212          return ((addr != cpu_to_le64(0x0000000000000000ULL)) ||
   213                  (addr != cpu_to_le64(0xffffffffffffffffULL)));

The current code always returns true.  It looks like the static checker
suggestion of change || to && is the correct fix?

   214  }

regards,
dan carpenter
