Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34273 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbaKQJ0K (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 04:26:10 -0500
Received: by mail-lb0-f178.google.com with SMTP id f15so17224780lbj.37
        for <linux-wpan@vger.kernel.org>; Mon, 17 Nov 2014 01:26:09 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 17 Nov 2014 14:56:09 +0530
Message-ID: <CAEUmHyayKKHF0RfjZvMDM0WjNj=vP7hL5B8h69ZaVv=Y59t0iQ@mail.gmail.com>
Subject: Power Management support for IEEE-802.15.4 drivers
From: Varka Bhadram <varkabhadram@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

None of IEEE-802.15.4 drivers implement power management. But devices
(AT86RF230, CC2520) will operate in different power modes.

Why cant we add these functionalities to the driver, so that we can
save the overall system power.

Thanks and Regards,
Varka Bhadram,
