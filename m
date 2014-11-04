Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:41061 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaKDABv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Nov 2014 19:01:51 -0500
Received: by mail-la0-f47.google.com with SMTP id gd6so9100986lab.20
        for <linux-wpan@vger.kernel.org>; Mon, 03 Nov 2014 16:01:49 -0800 (PST)
Date: Tue, 4 Nov 2014 01:01:41 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ieee802154: add extended address validation helper
Message-ID: <20141104000139.GA23799@omega>
References: <20141103204113.GA32352@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141103204113.GA32352@mwanda>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-wpan@vger.kernel.org

Hi Dan Carpenter,

On Mon, Nov 03, 2014 at 11:41:13PM +0300, Dan Carpenter wrote:
> Hello Alexander Aring,
> 
> The patch cb904b0a1630: "ieee802154: add extended address validation
> helper" from Nov 2, 2014, leads to the following static checker
> warning:
> 
> 	include/linux/ieee802154.h:212 ieee802154_is_valid_extended_addr()
> 	warn: was && intended here instead of ||?
> 
> include/linux/ieee802154.h
>    201  /**
>    202   * ieee802154_is_valid_psdu_len - check if extended addr is valid
>    203   * @addr: extended addr to check
>    204   */
>    205  static inline bool ieee802154_is_valid_extended_addr(const __le64 addr)
>    206  {
>    207          /* These EUI-64 addresses are reserved by IEEE. 0xffffffffffffffff
>    208           * is used internally as extended to short address broadcast mapping.
>    209           * This is currently a workaround because neighbor discovery can't
>    210           * deal with short addresses types right now.
>    211           */
>    212          return ((addr != cpu_to_le64(0x0000000000000000ULL)) ||
>    213                  (addr != cpu_to_le64(0xffffffffffffffffULL)));
> 
> The current code always returns true.  It looks like the static checker
> suggestion of change || to && is the correct fix?
> 

yes, you are right. Thanks for the suggestion. Do you want to fix that
and send a patch based on bluetooth-next or should I queue this for my
next series?

- Alex
