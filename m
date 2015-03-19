Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:59248 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751234AbbCSNq3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 19 Mar 2015 09:46:29 -0400
Message-ID: <1426772786.23529.4.camel@x220>
Subject: Re: [PATCH] mac802154: fix typo in header guard
From: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 19 Mar 2015 14:46:26 +0100
In-Reply-To: <20150319133724.GA14436@omega>
References: <1426771420-29979-1-git-send-email-nicolas.iooss_linux@m4x.org>
	 <20150319133724.GA14436@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Nicolas Iooss <nicolas.iooss_linux@m4x.org>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, marcel@holtmann.org

On Thu, 2015-03-19 at 14:37 +0100, Alexander Aring wrote:
> On Thu, Mar 19, 2015 at 09:23:40PM +0800, Nicolas Iooss wrote:
> > Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> > Fixes: b6eea9ca354a ("mac802154: introduce driver-ops header")
> 
> Acked-by: Alexander Aring <alex.aring@gmail.com>
> 
> can you please queue this into bluetooth-next or even bluetooth?

Is the Fixes: tag needed?

mac802154.ko builds fine on my machine. There's also no error or warning
included in the commit explanation. So it seems this is just a typo fix,
not something that should be sent to stable too. Or did I miss something
non-obvious?


Paul Bolle

