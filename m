Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from poseidon.ceid.upatras.gr ([150.140.141.169]:33462 "EHLO
        poseidon.ceid.upatras.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934470AbdEOOvM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 15 May 2017 10:51:12 -0400
Received: from mail.ceid.upatras.gr (mail.ceid.upatras.gr [10.1.0.174])
        by poseidon.ceid.upatras.gr (Postfix) with ESMTP id A783080CC1
        for <linux-wpan@vger.kernel.org>; Mon, 15 May 2017 17:51:01 +0300 (EEST)
Received: from webmail.ceid.upatras.gr (web.ceid.upatras.gr [10.1.0.173])
        (Authenticated sender: bardoutsos)
        by mail.ceid.upatras.gr (Postfix) with ESMTPSA id 98B68209C9
        for <linux-wpan@vger.kernel.org>; Mon, 15 May 2017 17:51:01 +0300 (EEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2017 16:50:57 +0200
From: Andreas Bardoutsos <bardoutsos@ceid.upatras.gr>
Subject: llsec:key retrieval fails
Message-ID: <562fd13530e9e287ac7a85e0931bcbce@ceid.upatras.gr>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi all!
I have managed to have a working setup with rpi running kernel 4.7.y 
with an AT86RF233(openlabs) tranceiver and i want to enable 
llsec.However ping6 always fails and on dmesg I get the message 
"encryption fails:-126".After some research i found out that on file: 
net/802154/llsec.c on line 1014 function llsec_lookup_seclevel always 
fails with error 22(invalid argument) and as a result encryption fails 
because it can not find the right key(or that is what i have 
understood).

This is my script which enables llsec according to the guide:

iwpan dev wpan0 set security 1
iwpan dev wpan0 key add 2 
00:01:02:03:04:05:06:07:08:09:0A:0B:0C:0D:0E:0F 0 0xabcd 3 
0x00124b0007a84380
iwpan dev wpan0 seclevel add 0xff 2 0
iwpan dev wpan0 device add 0 0xabcd 0xffff 0x00124b0007a84380 0 0
iwpan dev wpan0 set out_level 0x05
iwpan dev wpan0 set out_key_id 0 0xabcd 2 0xffff 3 0x00124b0007a84380

However on wireshark,security level is recognised as 0x5 but MIC check 
fails.What might be the issue?
Thank you!

-- 
--
Andreas Bardoutsos
Undergraduate student
@
Computer Engineering Informatics Department(CEID)
University of Patras,Greece
