Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:64023 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751520AbeBAK3W (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 1 Feb 2018 05:29:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 35C4D2B600
        for <linux-wpan@vger.kernel.org>; Thu,  1 Feb 2018 02:29:22 -0800 (PST)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wNJQfUtx6mn0 for <linux-wpan@vger.kernel.org>;
        Thu,  1 Feb 2018 02:29:14 -0800 (PST)
Received: from [192.168.2.108] (p4FE71175.dip0.t-ipconnect.de [79.231.17.117])
        by osg.samsung.com (Postfix) with ESMTPSA id 54DA22B5F7
        for <linux-wpan@vger.kernel.org>; Thu,  1 Feb 2018 02:29:14 -0800 (PST)
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: wpan-tools 0.8 release
Message-ID: <dea4d0e2-af43-1d46-2abe-ef947fa1298e@osg.samsung.com>
Date: Thu, 1 Feb 2018 11:29:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.


It is a pleasure to announce the 0.8 release of wpan-tools.
Thanks to everyone who contributed!

More of a maintenance release this time around. We did not have a release in a while and the build error with libnl >= 3.3 started to hit
more people. Having this fixed is worth a release alone. Thanks a lot to Thomas Petazzoni for the fix.

We also added some some examples on how to use the ieee802154 subsystem socket types from userspace.
Xue Wenqian added some more functionality to the wpan-ping utility. Mayn thanks here as well.

https://github.com/linux-wpan/wpan-tools/releases/download/wpan-tools-0.8/wpan-tools-0.8.tar.gz

sha256sum: 0e22cadbc40d4c12d0a66e8175bda12046f03237ce6da23d4fd26fd3ab557d8b

https://github.com/linux-wpan/wpan-tools/releases/download/wpan-tools-0.8/wpan-tools-0.8.tar.xz

sha256sum: daacd38fe2f216095664dbf2628151c8f632d3f122d526059a37ba3cc4d3d8af


Stefan Schmidt (9):
examples: add README with details to the various examples
examples: af_ieee802154_tx example
examples: af_ieee802154_rx example
examples: add af_packet_rx example
examples: af_inet6_rx example
examples: af_packet_tx example
examples: af_inet6_tx example
examples: add .gitignore file for examples directory
Release 0.8

Thomas Petazzoni (1):
src/nl_extras.h: fix compatibility with libnl 3.3.0

Xue Wenqian (2):
wpan-ping: add the support to set wpan-ping interval
wpan-ping: Add the filtering function for frame receiving


regards

Stefan Schmidt

