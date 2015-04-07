Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36895 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbbDGNkn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 09:40:43 -0400
Received: by wiaa2 with SMTP id a2so19208658wia.0
        for <linux-wpan@vger.kernel.org>; Tue, 07 Apr 2015 06:40:42 -0700 (PDT)
Date: Tue, 7 Apr 2015 15:40:39 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv3 bluetooth-next 2/4] nl802154: add set interface cmd
Message-ID: <20150407134034.GE16415@omega>
References: <1428407393-16005-1-git-send-email-alex.aring@gmail.com>
 <1428407393-16005-3-git-send-email-alex.aring@gmail.com>
 <20150407135902.2b885270@zoidberg>
 <20150407122149.GA16415@omega>
 <20150407142930.662c0f92@zoidberg>
 <20150407125949.GB16415@omega>
 <20150407150232.75e3df70@zoidberg>
 <20150407132459.GD16415@omega>
 <20150407153213.2a063405@zoidberg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150407153213.2a063405@zoidberg>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

On Tue, Apr 07, 2015 at 03:32:13PM +0200, Phoebe Buckheister wrote:
> 
> Eh? No.
> 

Okay. :-)

> struct wpan_phy_support {
> 	bool lbt, aack;

for aack I would use max and min for frame_retries (need to be signed
integer) and the same logik like max_frame_retries parameter in driver
ops. So if s8 max_frame_retries and min_frame_retries -1 then we don't
support aack handling. 

> 	u16 min_be, max_be;

I think for the backoff exponents we need something like:

min_minbe and max_minbe

and

min_maxbe and max_maxbe

sounds a little bit ugly, but some transceivers can't change the maxbe
value.

> 	u32 pages;
> 	u32 channels[32];

This is already combined in channels_supported array for pages and channels.

> };
> 
> or something like that. A complete description of PHY capabilities, we
> might even export that to userspace somehow?
> 

yes, of course. I think we should implement then a nested nl attribute for
wpan_phy_supported things while wpan_phy dump.

- Alex
