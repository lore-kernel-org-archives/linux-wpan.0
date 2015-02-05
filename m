Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:45801 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbbBEJHz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Feb 2015 04:07:55 -0500
Date: Thu, 5 Feb 2015 10:07:50 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv5 bluetooth-next 0/3] 6lowpan: introduce nhc framework
Message-ID: <20150205090747.GB12279@omega>
References: <1420818179-18585-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1420818179-18585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Stefan Schmidt <s.schmidt@samsung.com>

On Fri, Jan 09, 2015 at 04:42:56PM +0100, Alexander Aring wrote:
> This patch series introduce the next header compression framework. Currently
> we support udp compression/uncompression only. This framework allow to add new
> next header compression formats easily.
> 
> If somebody wants to add a new header compression format and some information
> are missing while calling compression and uncompression callbacks. Please
> feel free to make framework changes according these callbacks.
> 

Marcel, ping?

Or should we apply it for the next release?

- Alex
