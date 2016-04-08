Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:53337 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751433AbcDHRe0 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 8 Apr 2016 13:34:26 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] ieee802154/adf7242: fix memory leak of firmware
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1460027764-27428-1-git-send-email-sudipm.mukherjee@gmail.com>
Date: Fri, 8 Apr 2016 10:34:16 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <F14084BA-6B7A-400C-A90F-A202C6E6848A@holtmann.org>
References: <1460027764-27428-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Alexander Aring <aar@pengutronix.de>, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

Hi Sudip,

> If the firmware upload or the firmware verification fails then we
> printed the error message and exited but we missed releasing the
> firmware.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
> drivers/net/ieee802154/adf7242.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

