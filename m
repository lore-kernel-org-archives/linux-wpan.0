Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33367 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933122AbcBYSWq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Feb 2016 13:22:46 -0500
Received: by mail-ob0-f177.google.com with SMTP id jq7so55901431obb.0
        for <linux-wpan@vger.kernel.org>; Thu, 25 Feb 2016 10:22:46 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 25 Feb 2016 22:22:45 +0400
Message-ID: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
Subject: 802.15.4G support?
From: Remi Philippe <remi@linqio.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello,

We’re currently developing a driver for RF215 (dual radio) using
6lowpan and are nearly done with it. We’ve figured out the current MAC
and PHY are built for 15.4 and not 15.4g which is a blocking point the
sub-ghz module.


It doesn’t look like there is a need for a huge amount of work to get
a basic version of it working (key ones we’ve seen are different MTU
and also some changes in the header like PHR).


Before jumping in coding, is anyone on the list already working on
this? Or has any starting points.


Thanks,

--
Rémi
