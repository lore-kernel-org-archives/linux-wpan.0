Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:54641 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbbDTSgm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Apr 2015 14:36:42 -0400
Date: Mon, 20 Apr 2015 20:36:40 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH] ieee802154: Add trace events for rdev->ops
Message-ID: <20150420183639.GB5248@bogon.m.sigxcpu.org>
References: <20150412120733.GA6181@bogon.m.sigxcpu.org>
 <20150417102749.GB3288@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150417102749.GB3288@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alexander,
On Fri, Apr 17, 2015 at 12:27:53PM +0200, Alexander Aring wrote:
> On Sun, Apr 12, 2015 at 02:07:33PM +0200, Guido Günther wrote:
> ...
> > +DECLARE_EVENT_CLASS(802154_le16_template,
> > +	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
> > +		 __le16 le16arg),
> > +	TP_ARGS(wpan_phy, wpan_dev, le16arg),
> > +	TP_STRUCT__entry(
> > +		WPAN_PHY_ENTRY
> > +		WPAN_DEV_ENTRY
> > +		__field(__le16, le16arg)
> > +	),
> > +	TP_fast_assign(
> > +		WPAN_PHY_ASSIGN;
> > +		WPAN_DEV_ASSIGN;
> > +		__entry->le16arg = __le16_to_cpu(le16arg);
> 
> When "__entry->le16arg" is type of "__le16" which is given by
> "__field(__le16, le16arg)". Then translation of __le16_to_cpu is here
> wrong because __le16_to_cpu return u16.
> 
> > +	),
> > +	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT ", pan id: 0x%04x",
> > +		  WPAN_PHY_PR_ARG, WPAN_DEV_PR_ARG, __entry->le16arg)
> 
> When then we need to do the translation here. The format string requires
> a host byte-order type. So it's __le16_to_cpu(__entry->le16arg), I don't
> know why sparse (the C=2) doesn't report about that.
> 
> This is like wireless it does at [0], but with a pointer. When wireless
> do that in kernelspace, then I have no idea why there is a cfg80211
> plugin which doing byte order translation at [1]. I think this not for
> parsing the argument, it's for correct handling of handling the display
> of __le16_to_cpup (We use __le16_to_cpu here).

Agreed. If we want to keep this le until it's printed we should delay conversion
up to the format string.

> Then we need a cfg802154 plugin in trace_cmd for handling "__le16_to_cpu"
> correct.

I think this is only needed you don't use the kernel's built in printing
so this could be done as a follow up once this is in.
Cheers,
 -- Guido
