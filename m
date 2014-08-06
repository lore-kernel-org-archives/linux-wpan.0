Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:46936 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbaHFLn3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 Aug 2014 07:43:29 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so2445337wes.6
        for <linux-wpan@vger.kernel.org>; Wed, 06 Aug 2014 04:43:28 -0700 (PDT)
Date: Wed, 6 Aug 2014 13:43:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140806114324.GB3995@omega>
References: <1407320016-2808-1-git-send-email-simon.vincent@xsilon.com>
 <20140806113754.GA3995@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140806113754.GA3995@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH linux-wpan] Add support for MRF24J40MC
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org, alan@signal11.us

Hi,

On Wed, Aug 06, 2014 at 01:37:54PM +0200, Alexander Aring wrote:
> >  
> > +enum modules { MRF24J40, MRF24J40MA, MRF24J40MC };
> > +

and maybe we should add a MRF24J40 prefix to the name of this enum to
avoid naming conflicts. Don't know if there is another enum which is
named modules, but this is likely.

- Alex
