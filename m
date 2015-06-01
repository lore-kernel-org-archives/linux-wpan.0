Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from host.almesberger.net ([204.10.140.10]:47394 "EHLO
	host.almesberger.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbbFAPSE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 11:18:04 -0400
Date: Mon, 1 Jun 2015 12:17:46 -0300
From: Werner Almesberger <werner@almesberger.net>
Subject: Re: [RFC ben-wpan] atusb: fw: add support for rzusbstick
Message-ID: <20150601151746.GW10959@ws>
References: <1432471058-2920-1-git-send-email-alex.aring@gmail.com>
 <5565969E.8060000@osg.samsung.com>
 <20150601133815.GB1195@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150601133815.GB1195@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

Alexander Aring wrote:
> I don't know why this timer runs on atusb. This is maybe useful for
> timing measures, but currently this increments a uint64_t inside some
> timer isr. I don't think that is really necessary to have some system
> clock. This will increase overhead when doing atusb main tasks.

It's for production testing. The chain is: timer -> timer_read()
-> ATUSB_TIMER (USB control message) -> atrf-xtal -> prod/atusb

- Werner
