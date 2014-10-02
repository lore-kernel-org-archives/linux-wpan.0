Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36256 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaJBJPk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 05:15:40 -0400
Received: by mail-wg0-f43.google.com with SMTP id k14so2879775wgh.26
        for <linux-wpan@vger.kernel.org>; Thu, 02 Oct 2014 02:15:39 -0700 (PDT)
Date: Thu, 2 Oct 2014 11:15:33 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan 0/3] Fix handling of skbs of type
 PACKET_OTHERHOST
Message-ID: <20141002091531.GA3850@omega>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, varkabhadram@gmail.com, jukka.rissanen@linux.intel.com

Hi Simon,

On Thu, Oct 02, 2014 at 09:56:43AM +0100, Simon Vincent wrote:
> This series of patches fix the cases where the pkt_type is overriden 
> resulting in skbs of type PACKET_OTHERHOST getting set to PACKET_HOST.
> Also it drops packets of PACKET_OTHERHOST type in the 6lowpan layer
> as there is not point processing them as they are dropped at the next
> layer.
> 

serie looks good, I took a fast look into this.

You hit the GENERIC 6LOWPAN branch and all patches have a dependency to
each other. Means all patches should go into bluetooth repo.

Marcel's bluetooth repository isn't based on current net, this is done
after the merge window. I think we should base it on bluetooth-next, but
it's a big issue... forget users for the current kernel, will be fixed
in the next version. I discuss this with Marcel at [0]. So we doesn't
matter to fix it in current/-stable versions. If somebody like to fix it,
he can do the effort and send it to -stable mailinglist.

Please rebase it on bluetooth-next and send it again to the bluetooth 
mailinglist in cc (also linux-wpan and Jukka, me, etc..).


- Alex

[0] (was somewhere on linux-wpan with Marcel, we don't have a mail archive for this)
