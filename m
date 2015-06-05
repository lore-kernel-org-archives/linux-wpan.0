Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37657 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbbFEKy0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 06:54:26 -0400
Received: by wifx6 with SMTP id x6so16465776wif.0
        for <linux-wpan@vger.kernel.org>; Fri, 05 Jun 2015 03:54:25 -0700 (PDT)
Date: Fri, 5 Jun 2015 12:54:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 0/3] wpan-ping utility
Message-ID: <20150605105421.GB30035@omega>
References: <1433424323-24099-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433424323-24099-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 04, 2015 at 03:25:20PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> I had something similar around for a while and it proofed useful for some basic
> testing on the ieee 802154 level. It also can be used to see if we regress for
> non-6lowpan use cases like short address and ieee802154 sockets.
> 
> The only two things missing from my point of view is support for extended
> addresses and using recvfrom to avoid specifying the client address on server
> side.
> 

Applied, thanks.
