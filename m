Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:48777 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaHNIYx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Aug 2014 04:24:53 -0400
Received: by mail-we0-f182.google.com with SMTP id k48so757370wev.13
        for <linux-wpan@vger.kernel.org>; Thu, 14 Aug 2014 01:24:52 -0700 (PDT)
Date: Thu, 14 Aug 2014 10:24:49 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140814082447.GB19852@omega>
References: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
 <53EC6734.6050503@xsilon.com>
 <20140814075900.GA19177@omega>
 <53EC6ED7.6020009@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53EC6ED7.6020009@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH wpan-next 00/11] ieee802154: mac802154: wireless
 transformation
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Aug 14, 2014 at 09:09:59AM +0100, Martin Townsend wrote:
> It would be good to have a way of cleanly putting devices into promiscuous mode, currently we have to patch the mrf driver to do this.
> 
hacked solution which came not mainline because it had some issues which
I don't know yet anymore.

https://github.com/linux-wpan/linux-wpan-next/commit/55d497e2d8dc08d0673bb9be24d649a79afc5e9e

- Alex
