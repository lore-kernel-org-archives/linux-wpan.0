Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from picapica.im ([88.198.95.67]:50070 "EHLO picapica.im"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbeAUMaH (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 21 Jan 2018 07:30:07 -0500
Date: Sun, 21 Jan 2018 13:24:54 +0100
From: anton@picapica.im
Subject: reading RSSI value
Message-ID: <20180121122454.GA24136@picapica.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello

Is it possible to somehow read RSSI (Received Signal Strength indicator) value for each ieee802154 frame
received using raw socket? Quick grepping in kernel and wpan-tools sources says no, but just wanted to
confirm. Could energy detection level value used instead? Also, is it possible to set transmitter power
from userspace?

Thanks

Anton

