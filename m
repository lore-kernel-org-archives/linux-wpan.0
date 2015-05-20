Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60987 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbbETIp3 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 May 2015 04:45:29 -0400
Message-ID: <555C49A5.40202@osg.samsung.com>
Date: Wed, 20 May 2015 10:45:25 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 21/34] ieee802154: add support for atusb
 transceiver
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com> <1431891910-32231-22-git-send-email-alex.aring@gmail.com> <555B1531.3060500@osg.samsung.com>
In-Reply-To: <555B1531.3060500@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Werner Almesberger <werner@almesberger.net>, Richard Sharpe <realrichardsharpe@gmail.com>

Hello.

On 19/05/15 12:49, Stefan Schmidt wrote:
>
> Besides the mentioned things this looks fine. Will give it some 
> testing later this week.

Testing showed no further problems. Driver loads fine, detects the 
hardware and I'm able to configure it and send ping's over 6LoWPAN to 
another node.

regards
Stefan Schmidt
