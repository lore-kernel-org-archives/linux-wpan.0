Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41624 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751103AbcBWJ3G (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 23 Feb 2016 04:29:06 -0500
Subject: Re: [PATCH] mrf24j40: fix security-enabled processing on inbound
 frames
References: <56C60EBA.2070707@zopieux.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <56CC265C.2040906@pengutronix.de>
Date: Tue, 23 Feb 2016 10:29:00 +0100
MIME-Version: 1.0
In-Reply-To: <56C60EBA.2070707@zopieux.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alan Ott <alan@signal11.us>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, zopieux <web@zopieux.com>

Hi,

Alan, do you have some comments about that?

Currently the mrf24j40 goes into a deadlock if a frame with security
enable bit is set. As you see, I helped myself to create this patch and solve
this stupid default behaviour of mrf24j40. :-)

- Alex
