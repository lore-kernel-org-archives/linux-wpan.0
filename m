Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36309 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJBJ2J (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 05:28:09 -0400
Received: by mail-wi0-f174.google.com with SMTP id cc10so3294873wib.7
        for <linux-wpan@vger.kernel.org>; Thu, 02 Oct 2014 02:28:08 -0700 (PDT)
Date: Thu, 2 Oct 2014 11:28:06 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan 0/3] Fix handling of skbs of type
 PACKET_OTHERHOST
Message-ID: <20141002092804.GC3850@omega>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, varkabhadram@gmail.com, jukka.rissanen@linux.intel.com

On Thu, Oct 02, 2014 at 09:56:43AM +0100, Simon Vincent wrote:
> This series of patches fix the cases where the pkt_type is overriden 
> resulting in skbs of type PACKET_OTHERHOST getting set to PACKET_HOST.
> Also it drops packets of PACKET_OTHERHOST type in the 6lowpan layer
> as there is not point processing them as they are dropped at the next
> layer.

Please don't forget:

$ grep -r -n "PACKET_HOST" net/bluetooth/6lowpan.c

276:		local_skb->pkt_type = PACKET_HOST;

- Alex
