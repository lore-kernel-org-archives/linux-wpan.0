Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:34617 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753661AbdBPI4b (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 16 Feb 2017 03:56:31 -0500
Received: by mail-ua0-f180.google.com with SMTP id 35so6690256uak.1
        for <linux-wpan@vger.kernel.org>; Thu, 16 Feb 2017 00:56:31 -0800 (PST)
MIME-Version: 1.0
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Thu, 16 Feb 2017 09:56:29 +0100
Message-ID: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
Subject: Register two 802.15.4 devices/interfaces in one driver
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello,

Now I am working on a driver for MCR20A radio chip from NXP. This chip
has a special feature: support two PAN networks. It means it can
operate on two different or the same channels with different PAN IDs,
short addresses and extended addresses. I suppose to add two 802.15.4
interfaces for this feature. And I have two questions:

1. how to add 802.15.4 devices ? Call ieee802154_register_hw() twice
with different struct ieee802154_hw ?

2. how to deal with tx and rx regarding two interfaces.

Thanks.

It is appropriate for any driver design suggestions about this chip.

Regards,

Xue Liu

--
