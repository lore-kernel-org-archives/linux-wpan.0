Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from host.almesberger.net ([204.10.140.10]:39922 "EHLO
	host.almesberger.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbbETQbk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 12:31:40 -0400
Date: Wed, 20 May 2015 13:31:25 -0300
From: Werner Almesberger <werner@almesberger.net>
Subject: Re: [PATCH atubs-fw 3/4] atusb/fw: Add build system support for
 adding a DFU suffix to the fw file
Message-ID: <20150520163125.GH10959@ws>
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
 <1432127894-4760-4-git-send-email-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432127894-4760-4-git-send-email-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

Stefan Schmidt wrote:
> DFU files need to have a valid DFU suffix which provides information
> about the USB vendor and product ID

Aah, more bureaucracy ! :)

> +		dfu-suffix -a $(NAME).dfu -d 0x$(USB_BCD_VERSION) -p 0x$(USB_PRODUCT_ID) -v 0x$(USB_VENDOR_ID)

Would be nice to keep wc -L <= 80, though.

- Werner
