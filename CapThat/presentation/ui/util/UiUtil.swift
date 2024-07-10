//
//  UiUtil.swift
//  CapThat
//
//  Created by Aman Kumar on 10/07/24.
//

import AVKit

extension CMTime {
    static func milliseconds(_ milliseconds: Int) -> CMTime {
        return CMTime(value: CMTimeValue(milliseconds), timescale: 1000)
    }
}
