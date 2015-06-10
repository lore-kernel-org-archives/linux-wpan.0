Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47354 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933202AbbFJIlt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Jun 2015 04:41:49 -0400
Date: Wed, 10 Jun 2015 10:41:44 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: nl802154 enum misspelled, just send patch?
Message-ID: <20150610084144.GB20831@arazu>
References: <20150610082449.GA20831@arazu>
 <5577F5A0.9050100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5577F5A0.9050100@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 10, 2015 at 02:00:24PM +0530, Varka Bhadram wrote:
> On 06/10/2015 01:54 PM, Christoffer Holmstedt wrote:
> 
> >Hi
> >While working on the CCA improvements to wpan-tools I noticed that one of the
> >enums has a value misspelled. As the header is not in UAPI yet I suggest we
> >fix this.
> >
> >NL802154_CCA_UWB_MULTIPEXED is missing an l (ell) in multiplexed.
> >
> >The header file is included in wpan-tools repository and available in the
> >kernel. Should I just send a patch for bluetooth-next and then the new header
> >file is copied over to wpan-tools repository or what is the procedure here?
> >
> >I assume normal procedure for more "stable" user-space software is that the
> >kernel header file(s) should not be included in the user-space tool but instead
> >included and linked against the kernel headers (from running system or similiar
> >source). At the moment the nl802154 header is included in wpan-tools to make it
> >easier to build while developing.
> >
> >So, should I send a patch for both bluetooth-next and wpan-tools or just
> >bluetooth-next?
> 
> Send patch for both trees .  :-)
> 
> -- 
> Varka Bhadram

Will do.

-- 
Christoffer Holmstedt
