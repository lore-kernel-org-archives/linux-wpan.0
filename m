Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:56771
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754192AbcITItk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Sep 2016 04:49:40 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: wpan-tools 0.7 release
Message-ID: <c691e759-b0e3-35a4-7dd5-915b3f609e1d@osg.samsung.com>
Date: Tue, 20 Sep 2016 10:49:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Cc: c.schoenert@t-online.de, pbrobinson@gmail.com

Hello.

It is a pleasure to announce the 0.7 release of wpan-tools.
Thanks to everyone who contributed!

A smaller release with network namespaces support as the biggest new 
feature. Combined with some smaller fixes. We are also celebrating our 
100th commit in the repository.

We switched from bzip2 to xz as our extra compression format. You might 
need to update your packaging scripts. Good old gz is still around.

Downloads and md5sums:

http://wpan.cakelab.org/releases/wpan-tools-0.7.tar.xz
91f0b640ff66910e977fab6525625624

http://wpan.cakelab.org/releases/wpan-tools-0.7.tar.gz
06608f69951088844196f79685318aa9

Alexander Aring (2):
        update nl802154.h
        phy: add netns support

Stefan Schmidt (9):
        wpan-ping: ensure the memory for our config struct is initialized.
        wpan-ping: set more default values for our configuration
        wpan-ping: clarify help message for address setting
        info: remove confusing supported commands printout
        info: pretty print tx powers output
        info: pretty print ed levels output
        info: fix typo in tx power and ed level unit
        build: switch extra dist compressions from bzip2 to xz
        Release 0.7

regards
Stefan Schmidt
