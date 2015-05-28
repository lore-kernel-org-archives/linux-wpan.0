Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:60806 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbbE1QLP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 12:11:15 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH,RFC bluetooth-next 1/2] ieee802154: Fix generation of random EUI-64 addresses.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150528123832.GD11340@wantstofly.org>
Date: Thu, 28 May 2015 18:11:13 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <89CF4026-B917-42EB-B56A-61A25C7EEA63@holtmann.org>
References: <20150528123832.GD11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hi Lennert,

> Currently, ieee802154_random_extended_addr() has a 50% chance of
> generating a group (multicast) address, while this function is used
> for generating station addresses (which can't be group addresses)
> for interfaces that don't have a hardware-provided address.
> 
> Also, in case get_random_bytes() generates the EUI-64 address
> 00:00:00:00:00:00:00:00 (extremely unlikely), which is an invalid
> address, ieee802154_random_extended_addr() reacts by changing it
> to 01:00:00:00:00:00:00:00, which is an invalid station address as
> well, as it is a group address.
> 
> This patch changes the address generation procedure to grab eight
> random bytes, treat that as an EUI-64, and then clear the Group
> address bit and set the Locally Administered bit, which is in
> line with how eth_random_addr() generates random EUI-48s.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> ---
> include/linux/ieee802154.h | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

