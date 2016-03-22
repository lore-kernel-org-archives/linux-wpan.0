Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34994 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbcCVSsm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 22 Mar 2016 14:48:42 -0400
Received: by mail-wm0-f42.google.com with SMTP id l68so166190963wml.0
        for <linux-wpan@vger.kernel.org>; Tue, 22 Mar 2016 11:48:42 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 22 Mar 2016 19:48:41 +0100
Message-ID: <CAPpUg6Mc_OcRtws_qqM9gcrWfDH+MpsLt8zm6Q9ODABHThOzKw@mail.gmail.com>
Subject: at86rf212B 868Mhz
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I've got two devices with a at86rf212B onboard: device A (ohter OS
with at86rf212b driver) sending frame to device B  (running on Kernel
4.1 with the at86rf230 driver)
Both has got a 868MHz antenna.
Case 1: I set channel to 5 and page to 0 (914MHz according to
datasheet) to both of them, it works fine, I can receive and send
frames.
Case 2: I set channel to 0 and page to 0 (868MHz according to
dataheet) and I can't receive or send any frames.

Alexander, have you already tried to run on 868MHz?

Cheers,

-- 
Baptiste
