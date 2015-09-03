Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34296 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbbICNGW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Sep 2015 09:06:22 -0400
Received: by wicfx3 with SMTP id fx3so19315401wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 03 Sep 2015 06:06:21 -0700 (PDT)
Date: Thu, 3 Sep 2015 15:06:15 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] ieee802154: 6lowpan: use correct ESC
 value for dispatch
Message-ID: <20150903130611.GA15117@omega>
References: <1441284859-22191-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1441284859-22191-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Sep 03, 2015 at 02:54:19PM +0200, Stefan Schmidt wrote:
> The ESC dispatch value has some history and it originally was 0x7f in rfc4944
> (see section-5.1). With the release of rfc6282 this value got part of the
> LOWPAN_IPHC range and was no longer available for ESC. Instead 0x40 was used
> as replacement (see section-2 in rfc6282).
> 
> We have been checking the dispatch byte in an order where IPHC would always be
> evaluated before ESC and thus we would never reach the ESC check as the IPHC
> range already covers this value.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>
