Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from host.almesberger.net ([204.10.140.10]:44392 "EHLO
	host.almesberger.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbbE0Oq2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 10:46:28 -0400
Date: Wed, 27 May 2015 11:46:10 -0300
From: Werner Almesberger <werner@almesberger.net>
Subject: Re: [RFC ben-wpan] atusb: fw: add support for rzusbstick
Message-ID: <20150527144610.GK10959@ws>
References: <1432471058-2920-1-git-send-email-alex.aring@gmail.com>
 <5565969E.8060000@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5565969E.8060000@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

Stefan Schmidt wrote:
> Actually there is some logic inside dfu-util which could handle
> this. Firmware wise we don't check as far as I know.

The boot loader (DFU) is also designed such that, when you plug
in the device, it always runs first, no matter what you did to
the application. The boot loader itself is protected against
erasing or overwriting by code running on the chip. So it should
be fairly hard to terminally "brick" an atusb or anything using
the same architecture.

> Werner should know how the "USB
> registry" of Qi hardware works. Most likely a simple text file or
> wiki page.

Yup. You just add it to the Wiki:
http://en.qi-hardware.com/wiki/USB_product_ID_assignments

Lean bureaucracy ;-)

- Werner
