Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33057 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbbGMR3q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Jul 2015 13:29:46 -0400
Date: Mon, 13 Jul 2015 19:29:39 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 4/6] net: ieee802154: Remove redundant spi driver bus
 initialization
Message-ID: <20150713172936.GA824@omega>
References: <1435070714-24174-1-git-send-email-borneo.antonio@gmail.com>
 <1435071172-24542-1-git-send-email-borneo.antonio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1435071172-24542-1-git-send-email-borneo.antonio@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: Alan Ott <alan@signal11.us>, Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, marcel@holtmann.org

On Tue, Jun 23, 2015 at 10:52:52PM +0800, Antonio Borneo wrote:
> In ancient times it was necessary to manually initialize the bus
> field of an spi_driver to spi_bus_type. These days this is done in
> spi_register_driver(), so we can drop the manual assignment.
> 

Marcel,

I don't see this patch in any linux-next, net-next, bluetooth-next tree.
Could you please apply this patch with the acks by Alan and Varka?

- Alex
