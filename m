Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:50915 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbbGNFHf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 14 Jul 2015 01:07:35 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 4/6] net: ieee802154: Remove redundant spi driver bus initialization
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1435071172-24542-1-git-send-email-borneo.antonio@gmail.com>
Date: Tue, 14 Jul 2015 07:07:31 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <37171F2A-C41E-476A-A07C-72249A1757A5@holtmann.org>
References: <1435070714-24174-1-git-send-email-borneo.antonio@gmail.com> <1435071172-24542-1-git-send-email-borneo.antonio@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: Alan Ott <alan@signal11.us>, Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Antonio,

> In ancient times it was necessary to manually initialize the bus
> field of an spi_driver to spi_bus_type. These days this is done in
> spi_register_driver(), so we can drop the manual assignment.
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> To: Alan Ott <alan@signal11.us>
> To: Alexander Aring <alex.aring@gmail.com>
> To: Varka Bhadram <varkabhadram@gmail.com>
> To: linux-wpan@vger.kernel.org
> To: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> drivers/net/ieee802154/cc2520.c   | 1 -
> drivers/net/ieee802154/mrf24j40.c | 1 -
> 2 files changed, 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

