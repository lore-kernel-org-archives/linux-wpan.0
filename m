Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:60940 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbbBNVda (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Feb 2015 16:33:30 -0500
Date: Sat, 14 Feb 2015 22:33:22 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv5 bluetooth-next 0/3] 6lowpan: introduce nhc framework
Message-ID: <20150214213321.GA4035@omega>
References: <1420818179-18585-1-git-send-email-alex.aring@gmail.com>
 <20150205090747.GB12279@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150205090747.GB12279@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Stefan Schmidt <s.schmidt@samsung.com>

On Thu, Feb 05, 2015 at 10:07:47AM +0100, Alexander Aring wrote:
> On Fri, Jan 09, 2015 at 04:42:56PM +0100, Alexander Aring wrote:
> > This patch series introduce the next header compression framework. Currently
> > we support udp compression/uncompression only. This framework allow to add new
> > next header compression formats easily.
> > 
> > If somebody wants to add a new header compression format and some information
> > are missing while calling compression and uncompression callbacks. Please
> > feel free to make framework changes according these callbacks.
> > 
> 
> Marcel, ping?
> 

ping, again. :-)

- Alex
